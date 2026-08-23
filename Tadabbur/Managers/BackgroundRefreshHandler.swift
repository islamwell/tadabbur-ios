import Foundation
import BackgroundTasks

// MARK: - BackgroundRefreshHandler

/// Registers and handles BGAppRefreshTask for ayah rotation while the app is backgrounded.
/// Call `registerTask()` early in app launch (before the app finishes launching).
enum BackgroundRefreshHandler {

    static let taskIdentifier = "com.tadabbur.refresh"
    private static let refreshInterval: TimeInterval = 30 * 60 // 30 minutes

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

    /// Schedules the next background refresh ~30 minutes from now.
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
        // Schedule the next refresh immediately so the chain continues
        scheduleNextRefresh()

        // Perform ayah rotation
        let store = AyahStore()
        store.checkAndRotateIfOverdue()

        // Update the notification content for the rotated ayah
        NotificationManager.shared.updateSchedule(
            enabled: UserDefaults.standard.bool(forKey: "notificationEnabled"),
            ayah: store.currentAyah
        )

        task.setTaskCompleted(success: true)

        // Cancel handler: clean up if the system kills us mid-task
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
    }
}
