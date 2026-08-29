import SwiftUI
import BackgroundTasks

@main
struct TadabburApp: App {

    @StateObject private var ayahStore = AyahStore()
    @StateObject private var settingsStore = SettingsStore()
    @StateObject private var audioPlayer = AudioPlayer()

    init() {
        // Register the BGAppRefreshTask handler before the app finishes launching.
        // Per Apple docs this must happen before the end of application(_:didFinishLaunchingWithOptions:).
        BackgroundRefreshHandler.registerTask()
    }

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(ayahStore)
                .environmentObject(settingsStore)
                .environmentObject(audioPlayer)
                .onAppear {
                    // Request notification permission on first launch
                    NotificationManager.shared.requestAuthorization { granted in
                        if granted && settingsStore.notificationEnabled {
                            NotificationManager.shared.scheduleDailyNotifications(
                                from: settingsStore
                            )
                        }
                    }
                    // Schedule background refresh
                    BackgroundRefreshHandler.scheduleNextRefresh()
                }
        }
    }
}
