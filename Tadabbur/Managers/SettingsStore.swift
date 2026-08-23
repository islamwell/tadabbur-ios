import Foundation
import Combine

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
    }
}
