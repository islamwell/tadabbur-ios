import SwiftUI
import Combine

// MARK: - ReflectionOverlayView

/// Full-screen immersive reflection view shown on every foreground entry.
/// Displays the current ayah with a countdown before Continue appears.
struct ReflectionOverlayView: View {

    @EnvironmentObject private var ayahStore: AyahStore
    @EnvironmentObject private var settingsStore: SettingsStore
    @EnvironmentObject private var audioPlayer: AudioPlayer

    @Binding var isPresented: Bool

    // MARK: Countdown State

    /// Progress from 0.0 (start) to 1.0 (complete)
    @State private var progress: Double = 0.0
    @State private var continueVisible = false
    @State private var timerCancellable: AnyCancellable?

    /// Tick rate: 20Hz (every 0.05s) — satisfies ≥10Hz requirement
    private let tickInterval: Double = 0.05

    // MARK: Body

    var body: some View {
        ZStack {
            // Layered background
            backgroundLayer

            // Content
            VStack(spacing: 0) {
                emergencyButton
                    .padding(.top, 60)
                    .padding(.trailing, 24)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                Spacer()

                mainContent

                Spacer()

                bottomSection
                    .padding(.bottom, 52)
                    .padding(.horizontal, 28)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            audioPlayer.load(ayah: ayahStore.currentAyah)
            startCountdown()
        }
        .onDisappear {
            stopCountdown()
            audioPlayer.stop()
        }
    }

    // MARK: Background

    private var backgroundLayer: some View {
        ZStack {
            // Base gradient
            LinearGradient(
                colors: [Color("EmeraldDeep"), Color("NightBlue")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Ambient radial glow — top-left
            RadialGradient(
                colors: [Color("EmeraldLight").opacity(0.25), .clear],
                center: .topLeading,
                startRadius: 0,
                endRadius: 350
            )

            // Ambient radial glow — bottom-right
            RadialGradient(
                colors: [Color("NightBlue").opacity(0.5), .clear],
                center: .bottomTrailing,
                startRadius: 0,
                endRadius: 300
            )
        }
        .ignoresSafeArea()
    }

    // MARK: Emergency Button

    private var emergencyButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Skip")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .overlay(
                    Capsule()
                        .stroke(Color.red.opacity(0.6), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Skip reflection")
        .accessibilityHint("Immediately dismiss the overlay without waiting")
    }

    // MARK: Main Content

    private var mainContent: some View {
        VStack(spacing: 28) {
            // Surah chip
            SurahChipView(ayah: ayahStore.currentAyah)

            // Arabic text
            Text(ayahStore.currentAyah.arabicText)
                .font(.custom("Amiri-Regular", size: 28))
                .multilineTextAlignment(.trailing)
                .lineSpacing(12)
                .foregroundColor(.white)
                .environment(\.layoutDirection, .rightToLeft)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 28)

            // Ornamental divider
            OrnamentDividerView()
                .padding(.horizontal, 40)

            // English translation
            Text(ayahStore.currentAyah.translation)
                .font(.system(size: 17, weight: .light))
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.85))
                .lineSpacing(7)
                .padding(.horizontal, 28)

            // Arabic reference (small, below translation)
            Text(ayahStore.currentAyah.arabicReference)
                .font(.custom("Amiri-Regular", size: 14))
                .foregroundColor(.white.opacity(0.45))
                .environment(\.layoutDirection, .rightToLeft)
        }
    }

    // MARK: Bottom Section

    private var bottomSection: some View {
        VStack(spacing: 24) {
            // Audio button
            AudioButtonView()
                .environmentObject(audioPlayer)

            // Countdown progress bar
            countdownBar

            // Continue button
            ContinueButton(isVisible: continueVisible) {
                dismiss()
            }
        }
    }

    private var countdownBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Track
                Capsule()
                    .fill(.white.opacity(0.15))
                    .frame(height: 3)

                // Fill
                Capsule()
                    .fill(Color("EmeraldLight"))
                    .frame(width: geo.size.width * progress, height: 3)
                    .animation(.linear(duration: tickInterval), value: progress)
            }
        }
        .frame(height: 3)
        .accessibilityLabel("Reflection countdown")
        .accessibilityValue(continueVisible ? "Complete" : "\(Int(progress * 100))%")
    }

    // MARK: Countdown Logic

    private func startCountdown() {
        progress = 0.0
        continueVisible = false

        let duration = Double(settingsStore.pauseDuration)
        let totalTicks = duration / tickInterval
        var tickCount: Double = 0

        timerCancellable = Timer.publish(every: tickInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [self] _ in
                tickCount += 1
                progress = min(tickCount / totalTicks, 1.0)
                if progress >= 1.0 {
                    continueVisible = true
                    stopCountdown()
                }
            }
    }

    private func stopCountdown() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    // MARK: Dismiss

    private func dismiss() {
        stopCountdown()
        audioPlayer.stop()
        isPresented = false
    }
}

#Preview {
    ReflectionOverlayView(isPresented: .constant(true))
        .environmentObject(AyahStore())
        .environmentObject(SettingsStore())
        .environmentObject(AudioPlayer())
}
