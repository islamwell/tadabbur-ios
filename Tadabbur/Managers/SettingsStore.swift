import Foundation
import Combine

// MARK: - Notification Schedule Mode

enum NotificationScheduleMode: String, CaseIterable, Identifiable {
    case evenlySpaced = "Evenly Spaced"
    case customTimes = "Custom Times"

    var id: String { rawValue }
}

// MARK: - SettingsStore

/// Persists user preferences via UserDefaults / @AppStorage equivalents.
/// Injected as @EnvironmentObject throughout the view tree.
final class SettingsStore: ObservableObject {

    /// Whether the reflection overlay is shown on foreground entry.
    @Published var overlayEnabled: Bool {
        didSet { UserDefaults.standard.set(overlayEnabled, forKey: "overlayEnabled") }
    }

    /// Whether lock-screen / background notifications are scheduled.
    @Published var notificationEnabled: Bool {
        didSet { UserDefaults.standard.set(notificationEnabled, forKey: "notificationEnabled") }
    }

    /// Pause duration in seconds before the Continue button appears (3–30).
    @Published var pauseDuration: Int {
        didSet { UserDefaults.standard.set(pauseDuration, forKey: "pauseDuration") }
    }

    /// Number of notifications per day (1 to 5).
    @Published var dailyNotificationCount: Int {
        didSet { UserDefaults.standard.set(dailyNotificationCount, forKey: "dailyNotificationCount") }
    }

    /// Notification schedule distribution mode (evenly spaced vs custom times).
    @Published var notificationScheduleMode: NotificationScheduleMode {
        didSet { UserDefaults.standard.set(notificationScheduleMode.rawValue, forKey: "notificationScheduleMode") }
    }

    /// Day start hour for evenly spaced notifications (e.g. 8 for 8:00 AM).
    @Published var dayStartHour: Int {
        didSet { UserDefaults.standard.set(dayStartHour, forKey: "dayStartHour") }
    }

    /// Day end hour for evenly spaced notifications (e.g. 22 for 10:00 PM).
    @Published var dayEndHour: Int {
        didSet { UserDefaults.standard.set(dayEndHour, forKey: "dayEndHour") }
    }

    /// Custom times for up to 5 notifications per day.
    @Published var customNotificationTimes: [Date] {
        didSet {
            let timestamps = customNotificationTimes.map { $0.timeIntervalSince1970 }
            UserDefaults.standard.set(timestamps, forKey: "customNotificationTimes")
        }
    }

    // MARK: Init

    init() {
        let defaults = UserDefaults.standard

        // overlayEnabled defaults to true
        if defaults.object(forKey: "overlayEnabled") == nil {
            overlayEnabled = true
        } else {
            overlayEnabled = defaults.bool(forKey: "overlayEnabled")
        }

        // notificationEnabled defaults to true
        if defaults.object(forKey: "notificationEnabled") == nil {
            notificationEnabled = true
        } else {
            notificationEnabled = defaults.bool(forKey: "notificationEnabled")
        }

        // pauseDuration defaults to 7
        if defaults.object(forKey: "pauseDuration") == nil {
            pauseDuration = 7
        } else {
            let stored = defaults.integer(forKey: "pauseDuration")
            pauseDuration = stored == 0 ? 7 : stored
        }

        // dailyNotificationCount defaults to 3 (1...5)
        let storedCount = defaults.integer(forKey: "dailyNotificationCount")
        dailyNotificationCount = (storedCount >= 1 && storedCount <= 5) ? storedCount : 3

        // notificationScheduleMode defaults to .evenlySpaced
        if let modeRaw = defaults.string(forKey: "notificationScheduleMode"),
           let mode = NotificationScheduleMode(rawValue: modeRaw) {
            notificationScheduleMode = mode
        } else {
            notificationScheduleMode = .evenlySpaced
        }

        // dayStartHour defaults to 8 (8:00 AM)
        let storedStart = defaults.integer(forKey: "dayStartHour")
        dayStartHour = (storedStart >= 0 && storedStart < 24) ? (defaults.object(forKey: "dayStartHour") == nil ? 8 : storedStart) : 8

        // dayEndHour defaults to 22 (10:00 PM)
        let storedEnd = defaults.integer(forKey: "dayEndHour")
        dayEndHour = (storedEnd >= 0 && storedEnd < 24) ? (defaults.object(forKey: "dayEndHour") == nil ? 22 : storedEnd) : 22

        // customNotificationTimes defaults (Fajr, Morning, Dhuhr/Asr, Maghrib, Night)
        let calendar = Calendar.current
        let today = Date()

        let defaultHourMinutes = [(5, 30), (9, 0), (13, 30), (18, 0), (21, 30)]
        let defaultDates: [Date] = defaultHourMinutes.compactMap { hour, min in
            calendar.date(bySettingHour: hour, minute: min, second: 0, of: today)
        }

        if let storedTimestamps = defaults.array(forKey: "customNotificationTimes") as? [Double],
           storedTimestamps.count >= 5 {
            customNotificationTimes = storedTimestamps.map { Date(timeIntervalSince1970: $0) }
        } else {
            customNotificationTimes = defaultDates
        }
    }

    // MARK: - Computed Target Times

    /// Calculates target notification times (hour and minute) for the active configuration.
    func targetNotificationTimes() -> [(hour: Int, minute: Int)] {
        let count = max(1, min(5, dailyNotificationCount))

        switch notificationScheduleMode {
        case .evenlySpaced:
            var results: [(hour: Int, minute: Int)] = []
            let start = dayStartHour
            let end = max(start + 1, dayEndHour)
            let totalSpanMinutes = (end - start) * 60

            if count == 1 {
                // Middle of the waking day
                let midMinutes = start * 60 + totalSpanMinutes / 2
                results.append((midMinutes / 60, midMinutes % 60))
            } else {
                let stepMinutes = Double(totalSpanMinutes) / Double(count - 1)
                for i in 0..<count {
                    let totalMin = Int(Double(start * 60) + Double(i) * stepMinutes)
                    let h = (totalMin / 60) % 24
                    let m = totalMin % 60
                    results.append((h, m))
                }
            }
            return results

        case .customTimes:
            let calendar = Calendar.current
            var results: [(hour: Int, minute: Int)] = []
            for i in 0..<count {
                let date = i < customNotificationTimes.count ? customNotificationTimes[i] : Date()
                let hour = calendar.component(.hour, from: date)
                let minute = calendar.component(.minute, from: date)
                results.append((hour, minute))
            }
            return results
        }
    }
}
