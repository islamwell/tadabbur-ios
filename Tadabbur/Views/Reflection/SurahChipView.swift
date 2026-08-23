import SwiftUI

// MARK: - SurahChipView

/// Pill-shaped label showing the surah name and ayah number.
/// e.g. "Al-Baqarah · 152"
struct SurahChipView: View {

    let ayah: Ayah

    var body: some View {
        Text(ayah.reference)
            .font(.system(size: 13, weight: .medium, design: .rounded))
            .foregroundColor(.white.opacity(0.8))
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(.white.opacity(0.12))
                    .overlay(
                        Capsule().stroke(.white.opacity(0.2), lineWidth: 0.5)
                    )
            )
    }
}

#Preview {
    SurahChipView(ayah: Ayah.catalog[0])
        .padding()
        .background(Color("EmeraldDeep"))
}
