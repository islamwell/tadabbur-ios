import Foundation
import UserNotifications

// MARK: - NotificationManager

/// Manages lock-screen / background notifications showing the current ayah.
/// Conforms to UNUserNotificationCenterDelegate to display foreground banners and handle taps.
final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {

    static let shared = NotificationManager()

    private let center = UNUserNotificationCenter.current()
    private let notificationID = "com.tadabbur.ayahReminder"

    private override init() {
        super.init()
        center.delegate = self
    }

    // MARK: - UNUserNotificationCenterDelegate

    /// Displays the notification banner even when the app is in the foreground.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound, .badge, .list])
        } else {
            completionHandler([.alert, .sound, .badge])
        }
    }

    /// Handles user tapping on a lock-screen or banner notification.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        NotificationCenter.default.post(name: NSNotification.Name("OpenReflectionOverlay"), object: nil)
        completionHandler()
    }

    // MARK: - Permission

    /// Requests notification authorization. Calls back on the main queue.
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("[NotificationManager] Auth error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    /// Checks current authorization status asynchronously.
    func checkAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }

    // MARK: - Scheduling

    /// Schedules (or reschedules) the repeating ayah reminder notification.
    /// - Parameters:
    ///   - ayah: The ayah whose content will appear in the notification.
    func scheduleRepeatingNotification(for ayah: Ayah) {
        center.removePendingNotificationRequests(withIdentifiers: [notificationID])

        let content = UNMutableNotificationContent()
        content.title = ayah.reference
        content.body = ayah.translation
        content.sound = .default
        if #available(iOS 15.0, *) {
            content.interruptionLevel = .timeSensitive
        }
        content.userInfo = ["arabicText": ayah.arabicText, "ayahID": ayah.id]

        // Repeat every 30 minutes
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30 * 60, repeats: true)

        let request = UNNotificationRequest(
            identifier: notificationID,
            content: content,
            trigger: trigger
        )

        center.add(request) { error in
            if let error = error {
                print("[NotificationManager] Failed to schedule repeating notification: \(error.localizedDescription)")
            }
        }
    }

    /// Cancels all pending Tadabbur notifications.
    func cancelAll() {
        center.removePendingNotificationRequests(withIdentifiers: [notificationID])
    }

    /// Schedules a test notification in a few seconds so the user can test lock screen display.
    func scheduleTestNotification(
        for ayah: Ayah,
        delaySeconds: TimeInterval = 3,
        completion: @escaping (Bool, String?) -> Void = { _, _ in }
    ) {
        center.getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization { granted in
                    if granted {
                        self.performScheduleTest(for: ayah, delaySeconds: delaySeconds, completion: completion)
                    } else {
                        DispatchQueue.main.async {
                            completion(false, "Notification permission was not granted. Please enable notifications in iOS Settings.")
                        }
                    }
                }
            case .denied:
                DispatchQueue.main.async {
                    completion(false, "Notifications are disabled for Tadabbur. Please tap 'Notification Settings' below to enable them.")
                }
            case .authorized, .provisional, .ephemeral:
                self.performScheduleTest(for: ayah, delaySeconds: delaySeconds, completion: completion)
            @unknown default:
                self.performScheduleTest(for: ayah, delaySeconds: delaySeconds, completion: completion)
            }
        }
    }

    private func performScheduleTest(
        for ayah: Ayah,
        delaySeconds: TimeInterval,
        completion: @escaping (Bool, String?) -> Void
    ) {
        let content = UNMutableNotificationContent()
        content.title = "تدبر · \(ayah.reference)"
        content.body = "\(ayah.arabicText)\n\n\(ayah.translation)"
        content.sound = .default
        if #available(iOS 15.0, *) {
            content.interruptionLevel = .timeSensitive
        }
        content.userInfo = ["arabicText": ayah.arabicText, "ayahID": ayah.id]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(delaySeconds, 1), repeats: false)
        let request = UNNotificationRequest(
            identifier: "com.tadabbur.testNotification.\(UUID().uuidString)",
            content: content,
            trigger: trigger
        )

        center.add(request) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("[NotificationManager] Failed to schedule test notification: \(error.localizedDescription)")
                    completion(false, error.localizedDescription)
                } else {
                    completion(true, nil)
                }
            }
        }
    }

    /// Sends a quick helper cheat sheet notification when switching to Apple Shortcuts.
    func scheduleCheatSheetNotification() {
        let content = UNMutableNotificationContent()
        content.title = "💡 Tadabbur Shortcuts Cheat Sheet"
        content.body = "1. Automation tab → 2. When unlocked → 3. Run Immediately → 4. Open App: Tadabbur"
        content.sound = .default
        if #available(iOS 15.0, *) {
            content.interruptionLevel = .timeSensitive
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(
            identifier: "com.tadabbur.cheatSheet.\(UUID().uuidString)",
            content: content,
            trigger: trigger
        )
        center.add(request)
    }

    // MARK: - Convenience

    /// Schedules if enabled; cancels if disabled.
    func updateSchedule(enabled: Bool, ayah: Ayah) {
        if enabled {
            checkAuthorizationStatus { [weak self] status in
                if status == .authorized {
                    self?.scheduleRepeatingNotification(for: ayah)
                }
            }
        } else {
            cancelAll()
        }
    }
}
