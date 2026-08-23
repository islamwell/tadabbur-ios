import SwiftUI

// MARK: - AyahPreviewCard

/// Compact card showing the current ayah's Arabic text and translation.
/// Used in the Settings screen to give context for the active verse.
struct AyahPreviewCard: View {

    let ayah: Ayah

    var body: some View {
        VStack(alignment: .center, spacing: 14) {
            SurahChipView(ayah: ayah)

            Text(ayah.arabicText)
                .font(.custom("Amiri-Regular", size: 20))
                .multilineTextAlignment(.trailing)
                .lineSpacing(8)
                .foregroundColor(.white)
                .environment(\.layoutDirection, .rightToLeft)
                .frame(maxWidth: .infinity, alignment: .trailing)

            OrnamentDividerView()

            Text(ayah.translation)
                .font(.system(size: 14, weight: .light))
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.75))
                .lineSpacing(5)
                .frame(maxWidth: .infinity)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color("EmeraldDeep"))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color("EmeraldLight").opacity(0.3), lineWidth: 1)
                )
        )
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
    }
}

#Preview {
    AyahPreviewCard(ayah: Ayah.catalog[0])
        .padding()
        .background(Color(.systemGroupedBackground))
}
