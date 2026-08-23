import SwiftUI

// MARK: - OrnamentDividerView

/// Decorative divider: ── ✦ ──
/// Hidden from accessibility — purely visual.
struct OrnamentDividerView: View {

    var body: some View {
        HStack(spacing: 10) {
            line
            Text("✦")
                .font(.system(size: 10))
                .foregroundColor(.white.opacity(0.35))
            line
        }
        .accessibilityHidden(true)
    }

    private var line: some View {
        Rectangle()
            .fill(.white.opacity(0.2))
            .frame(height: 0.5)
    }
}

#Preview {
    OrnamentDividerView()
        .padding()
        .background(Color("EmeraldDeep"))
}
