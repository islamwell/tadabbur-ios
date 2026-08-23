import SwiftUI

// MARK: - AudioButtonView

/// A beautiful, modern, and simple audio playback button for Quranic recitation.
/// Displays reciter information (Sheikh Nasser Al-Qatami), live animated sound waves,
/// smooth buffering spinner, hairline playback progress, and haptic feedback.
struct AudioButtonView: View {

    @EnvironmentObject private var audioPlayer: AudioPlayer

    @State private var isPressed = false
    @State private var wavePhase: CGFloat = 0

    var body: some View {
        Button {
            triggerHaptic()
            audioPlayer.togglePlayback()
        } label: {
            HStack(spacing: 12) {
                // Play / Pause / Loading Icon Container
                ZStack {
                    Circle()
                        .fill(audioPlayer.isPlaying ? Color("EmeraldLight") : Color.white.opacity(0.18))
                        .frame(width: 38, height: 38)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.35), lineWidth: 1)
                        )

                    if audioPlayer.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(0.8)
                    } else if audioPlayer.isPlaying {
                        // Animated 3-bar sound wave
                        EqualizerWaveView()
                            .frame(width: 16, height: 16)
                    } else {
                        Image(systemName: "play.fill")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .offset(x: 1.5) // optical alignment
                    }
                }

                // Reciter & Playback Info
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Nasser Al-Qatami")
                            .font(.system(size: 13.5, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)

                        if audioPlayer.isCachedLocally {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 10))
                                .foregroundColor(Color("EmeraldLight"))
                        }
                    }

                    if audioPlayer.isPlaying {
                        HStack(spacing: 4) {
                            Text(formatTime(audioPlayer.currentTime))
                                .font(.system(size: 11, weight: .medium, design: .monospaced))
                            Text("/")
                                .font(.system(size: 10))
                            Text(formatTime(audioPlayer.duration))
                                .font(.system(size: 11, weight: .regular, design: .monospaced))
                        }
                        .foregroundColor(Color("EmeraldLight"))
                    } else if audioPlayer.isLoading {
                        Text("Loading audio...")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.white.opacity(0.6))
                    } else {
                        Text("Listen to Recitation")
                            .font(.system(size: 11, weight: .regular))
                            .foregroundColor(.white.opacity(0.65))
                    }
                }

                Spacer(minLength: 4)

                // Right badge / wave icon
                if audioPlayer.isPlaying {
                    Image(systemName: "waveform")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("EmeraldLight"))
                } else {
                    Image(systemName: "headphones")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .padding(.leading, 8)
            .padding(.trailing, 16)
            .padding(.vertical, 8)
            .background(
                ZStack(alignment: .bottomLeading) {
                    // Glassmorphic background
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .fill(
                                    audioPlayer.isPlaying
                                        ? Color("EmeraldLight").opacity(0.18)
                                        : Color.white.opacity(0.06)
                                )
                        )

                    // Hairline Playback Progress Bar along bottom
                    if audioPlayer.isPlaying && audioPlayer.playbackProgress > 0 {
                        GeometryReader { geo in
                            Capsule()
                                .fill(Color("EmeraldLight"))
                                .frame(width: geo.size.width * CGFloat(audioPlayer.playbackProgress), height: 2.5)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    }

                    // Border Stroke
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(
                            audioPlayer.isPlaying
                                ? Color("EmeraldLight").opacity(0.6)
                                : Color.white.opacity(0.18),
                            lineWidth: 1
                        )
                }
            )
            .shadow(
                color: audioPlayer.isPlaying ? Color("EmeraldLight").opacity(0.25) : Color.black.opacity(0.15),
                radius: audioPlayer.isPlaying ? 12 : 4,
                x: 0,
                y: audioPlayer.isPlaying ? 4 : 2
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .accessibilityLabel(audioPlayer.isPlaying ? "Pause recitation" : "Play recitation by Nasser Al-Qatami")
    }

    // MARK: - Helpers

    private func formatTime(_ time: TimeInterval) -> String {
        guard !time.isNaN && !time.isInfinite && time > 0 else { return "0:00" }
        let mins = Int(time) / 60
        let secs = Int(time) % 60
        return String(format: "%d:%02d", mins, secs)
    }

    private func triggerHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// MARK: - Equalizer Sound Wave Animation

struct EqualizerWaveView: View {
    @State private var bar1Height: CGFloat = 4
    @State private var bar2Height: CGFloat = 12
    @State private var bar3Height: CGFloat = 8

    var body: some View {
        HStack(spacing: 2.5) {
            RoundedRectangle(cornerRadius: 1)
                .fill(Color.white)
                .frame(width: 2.5, height: bar1Height)
            RoundedRectangle(cornerRadius: 1)
                .fill(Color.white)
                .frame(width: 2.5, height: bar2Height)
            RoundedRectangle(cornerRadius: 1)
                .fill(Color.white)
                .frame(width: 2.5, height: bar3Height)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.45).repeatForever(autoreverses: true)) {
                bar1Height = 14
            }
            withAnimation(.easeInOut(duration: 0.35).repeatForever(autoreverses: true).delay(0.1)) {
                bar2Height = 6
            }
            withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.2)) {
                bar3Height = 15
            }
        }
    }
}

// MARK: - Scale Button Style

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Color("EmeraldDeep").ignoresSafeArea()
        AudioButtonView()
            .environmentObject(AudioPlayer())
            .padding(.horizontal, 30)
    }
}
