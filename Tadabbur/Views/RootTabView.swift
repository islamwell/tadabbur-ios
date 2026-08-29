import SwiftUI

// MARK: - RootTabView

/// Two-tab root: Reflection (home) + Settings.
/// Owns the overlay presentation state and listens for foreground entry.
struct RootTabView: View {

    @EnvironmentObject private var ayahStore: AyahStore
    @EnvironmentObject private var settingsStore: SettingsStore
    @EnvironmentObject private var audioPlayer: AudioPlayer

    @Environment(\.scenePhase) private var scenePhase
    /// Controls whether the full-screen reflection overlay is presented.
    @State private var showOverlay = false

    var body: some View {
        TabView {
            ReflectionHomeView(showOverlay: $showOverlay)
                .tabItem {
                    Label("Reflect", systemImage: "moon.stars.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .accentColor(.white)
        // Present the overlay full-screen whenever showOverlay becomes true
        .fullScreenCover(isPresented: $showOverlay) {
            ReflectionOverlayView(isPresented: $showOverlay)
                .environmentObject(ayahStore)
                .environmentObject(settingsStore)
                .environmentObject(audioPlayer)
        }
        .onAppear {
            handleForegroundEntry()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                handleForegroundEntry()
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIApplication.willEnterForegroundNotification
            )
        ) { _ in
            handleForegroundEntry()
        }
    }

    // MARK: Foreground Logic

    private func handleForegroundEntry() {
        // Check if rotation is due and rotate if so
        ayahStore.checkAndRotateIfOverdue()

        // Load audio for the (possibly new) current ayah
        audioPlayer.load(ayah: ayahStore.currentAyah)

        // Update notification with current settings
        NotificationManager.shared.updateSchedule(
            enabled: settingsStore.notificationEnabled,
            settingsStore: settingsStore
        )

        // Show overlay if the setting is on
        if settingsStore.overlayEnabled && !showOverlay {
            showOverlay = true
        }
    }
}

#Preview {
    RootTabView()
        .environmentObject(AyahStore())
        .environmentObject(SettingsStore())
        .environmentObject(AudioPlayer())
}
