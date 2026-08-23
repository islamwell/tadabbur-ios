import SwiftUI

// MARK: - ReflectionHomeView

/// The resting state of the Reflection tab.
/// Shows the current ayah on a gradient background.
/// Tapping the card reopens the reflection overlay manually.
struct ReflectionHomeView: View {

    @EnvironmentObject private var ayahStore: AyahStore
    @Binding var showOverlay: Bool
    @State private var showShortcutsGuide = false

    var body: some View {
        ZStack {
            // Background gradient
            backgroundGradient
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {
                    headerSection
                    ayahCard
                    openOverlayButton
                    shortcutsGuideButton
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
                .padding(.top, 60)
            }
        }
        .sheet(isPresented: $showShortcutsGuide) {
            ShortcutsGuideView()
        }
    }

    // MARK: Subviews

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color("EmeraldDeep"),
                Color("NightBlue")
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("تدبر")
                .font(.system(size: 42, weight: .light))
                .foregroundColor(.white.opacity(0.9))

            Text("Tadabbur")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.5))
                .tracking(4)
                .textCase(.uppercase)
        }
    }

    private var ayahCard: some View {
        VStack(alignment: .center, spacing: 20) {
            // Surah chip
            SurahChipView(ayah: ayahStore.currentAyah)

            // Arabic text
            Text(ayahStore.currentAyah.arabicText)
                .font(.custom("Amiri-Regular", size: 26))
                .multilineTextAlignment(.trailing)
                .lineSpacing(10)
                .foregroundColor(.white)
                .environment(\.layoutDirection, .rightToLeft)
                .frame(maxWidth: .infinity, alignment: .trailing)

            OrnamentDividerView()

            // Translation
            Text(ayahStore.currentAyah.translation)
                .font(.system(size: 16, weight: .light))
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.8))
                .lineSpacing(6)
                .frame(maxWidth: .infinity)

            // Verse counter
            Text("\(ayahStore.currentIndex) / \(ayahStore.totalCount)")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.4))
                .padding(.top, 4)
        }
        .padding(28)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white.opacity(0.07))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(.white.opacity(0.12), lineWidth: 1)
                )
        )
    }

    private var openOverlayButton: some View {
        Button {
            showOverlay = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "moon.stars")
                    .font(.system(size: 15, weight: .medium))
                Text("Reflect")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                Capsule()
                    .fill(Color("EmeraldLight").opacity(0.35))
                    .overlay(
                        Capsule().stroke(.white.opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }

    private var shortcutsGuideButton: some View {
        Button {
            showShortcutsGuide = true
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "sparkles")
                    .font(.system(size: 13))
                Text("Auto-Open on Unlock Setup")
                    .font(.system(size: 13, weight: .medium))
                Image(systemName: "chevron.right")
                    .font(.system(size: 10, weight: .semibold))
            }
            .foregroundColor(.white.opacity(0.7))
            .padding(.vertical, 8)
            .padding(.horizontal, 14)
            .background(
                Capsule()
                    .fill(.white.opacity(0.08))
                    .overlay(
                        Capsule().stroke(.white.opacity(0.12), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ReflectionHomeView(showOverlay: .constant(false))
        .environmentObject(AyahStore())
}
