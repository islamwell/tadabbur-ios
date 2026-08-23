import Foundation
import Combine

// MARK: - AyahStore

/// Manages the current ayah, rotation logic, and persistence.
/// Injected as @EnvironmentObject throughout the view tree.
final class AyahStore: ObservableObject {

    // MARK: Persisted State

    @Published private(set) var currentAyah: Ayah

    /// 0-based index into Ayah.catalog
    private var ayahIndex: Int {
        get { UserDefaults.standard.integer(forKey: "ayahIndex") }
        set { UserDefaults.standard.set(newValue, forKey: "ayahIndex") }
    }

    private var lastRotationDate: Date {
        get {
            (UserDefaults.standard.object(forKey: "lastRotationDate") as? Date) ?? Date()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lastRotationDate")
        }
    }

    // MARK: Init

    init() {
        let index = UserDefaults.standard.integer(forKey: "ayahIndex")
        let safeIndex = index % Ayah.catalog.count
        currentAyah = Ayah.catalog[safeIndex]

        // Seed rotation date on first launch
        if UserDefaults.standard.object(forKey: "lastRotationDate") == nil {
            UserDefaults.standard.set(Date(), forKey: "lastRotationDate")
        }
    }

    // MARK: Rotation

    /// Advances to the next ayah unconditionally and records the rotation time.
    func rotate() {
        let nextIndex = (ayahIndex + 1) % Ayah.catalog.count
        ayahIndex = nextIndex
        lastRotationDate = Date()
        currentAyah = Ayah.catalog[nextIndex]
    }

    /// Rotates only if ≥30 minutes have elapsed since the last rotation.
    /// Called every time the app enters the foreground.
    func checkAndRotateIfOverdue() {
        let elapsed = Date().timeIntervalSince(lastRotationDate)
        if elapsed >= 30 * 60 {
            rotate()
        }
    }

    /// Returns the current ayah's index (1-based) for display purposes.
    var currentIndex: Int { ayahIndex + 1 }

    /// Total number of ayahs in the catalog.
    var totalCount: Int { Ayah.catalog.count }
}
