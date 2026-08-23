import SwiftUI

// MARK: - ContinueButton

/// Full-width white capsule button that fades in after the countdown completes.
/// Hidden while the countdown is running.
struct ContinueButton: View {

    let isVisible: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Continue")
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundColor(Color("EmeraldDeep"))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    Capsule()
                        .fill(.white)
                )
        }
        .buttonStyle(.plain)
        .opacity(isVisible ? 1 : 0)
        .animation(.easeIn(duration: 0.3), value: isVisible)
        .allowsHitTesting(isVisible)
        .accessibilityLabel("Continue")
        .accessibilityHint("Dismiss the reflection overlay")
    }
}

#Preview {
    ContinueButton(isVisible: true) {}
        .padding()
        .background(Color("EmeraldDeep"))
}
