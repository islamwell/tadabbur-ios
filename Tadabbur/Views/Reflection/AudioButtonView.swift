import SwiftUI

// MARK: - AudioButtonView

/// 56×56 circular play/pause button.
/// Shows an animated pulse ring while playing.
/// Hidden entirely when audio is not available for the current ayah.
struct AudioButtonView: View {

    @EnvironmentObject private var audioPlayer: AudioPlayer

    @State private var isPulsing = false

    var body: some View {
        Group {
            if audioPlayer.audioAvailable {
                ZStack {
                    // Animated pulse ring (only while playing)
                    if audioPlayer.isPlaying {
                        Circle()
                            .stroke(Color("EmeraldLight").opacity(0.4), lineWidth: 1.5)
                            .frame(width: 70, height: 70)
                            .scaleEffect(isPulsing ? 1.3 : 1.0)
                            .opacity(isPulsing ? 0 : 0.6)
                            .animation(
                                .easeOut(duration: 1.2).repeatForever(autoreverses: false),
                                value: isPulsing
                            )
                    }

                    // Button circle
                    Circle()
                        .fill(Color("EmeraldLight").opacity(0.25))
                        .overlay(
                            Circle().stroke(.white.opacity(0.3), lineWidth: 1)
                        )
                        .frame(width: 56, height: 56)

                    Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .offset(x: audioPlayer.isPlaying ? 0 : 2) // optical centering for play icon
                }
                .frame(width: 70, height: 70)
                .onTapGesture {
                    audioPlayer.togglePlayback()
                }
                .onChange(of: audioPlayer.isPlaying) { playing in
                    isPulsing = playing
                }
                .onAppear {
                    isPulsing = audioPlayer.isPlaying
                }
                .accessibilityLabel(audioPlayer.isPlaying ? "Pause recitation" : "Play recitation")
                .accessibilityAddTraits(.isButton)
            }
        }
    }
}

#Preview {
    AudioButtonView()
        .environmentObject(AudioPlayer())
        .padding()
        .background(Color("EmeraldDeep"))
}
