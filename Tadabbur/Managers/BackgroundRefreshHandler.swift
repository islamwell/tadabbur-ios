import Foundation
import BackgroundTasks

// MARK: - BackgroundRefreshHandler

/// Registers and handles BGAppRefreshTask for ayah rotation while the app is backgrounded.
/// Call `registerTask()` early in app launch (before the app finishes launching).
enum BackgroundRefreshHandler {

    static let taskIdentifier = "com.tadabbur.refresh"
    private static let refreshInterval: TimeInterval = 40 * 60 // 40 minutes

    // MARK: Registration

    /// Register the background task handler. Must be called before app finishes launching.
    static func registerTask() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: taskIdentifier,
            using: nil
        ) { task in
            guard let refreshTask = task as? BGAppRefreshTask else { return }
            handle(task: refreshTask)
        }
    }

    // MARK: Scheduling

    /// Schedules the next background refresh ~40 minutes from now.
    static func scheduleNextRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: taskIdentifier)
        request.earliestBeginDate = Date(timeIntervalSinceNow: refreshInterval)

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("[BackgroundRefreshHandler] Could not schedule: \(error.localizedDescription)")
        }
    }

    // MARK: Task Handling

    private static func handle(task: BGAppRefreshTask) {
        // Register expiration handler immediately in case system cancels early
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }

        // Schedule the next refresh immediately so the chain continues
        scheduleNextRefresh()

        // Perform ayah rotation
        let store = AyahStore()
        store.checkAndRotateIfOverdue()

        // Update notification content
        NotificationManager.shared.updateSchedule(
            enabled: UserDefaults.standard.bool(forKey: "notificationEnabled")
        )

        task.setTaskCompleted(success: true)
    }
}
