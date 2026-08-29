import SwiftUI

// MARK: - LockScreenWidgetGuideView (Widget Wizard)

/// An interactive, visual step-by-step wizard guiding users on how to add
/// the Tadabbur Quranic Ayah widget to their iPhone Lock Screen.
struct LockScreenWidgetGuideView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var currentStep = 0

    private let totalSteps = 5

    var body: some View {
        NavigationStack {
            ZStack {
                // Dark background matching app theme
                LinearGradient(
                    colors: [
                        Color(red: 0.04, green: 0.12, blue: 0.16),
                        Color(red: 0.02, green: 0.06, blue: 0.09)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Top Progress & Step Indicators
                    stepProgressBar
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                        .padding(.bottom, 12)

                    // Swipeable Page Views
                    TabView(selection: $currentStep) {
                        stepOneView.tag(0)
                        stepTwoView.tag(1)
                        stepThreeView.tag(2)
                        stepFourView.tag(3)
                        stepFiveView.tag(4)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))

                    // Bottom Navigation Buttons
                    bottomNavigationBar
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                }
            }
            .navigationTitle("Lock Screen Setup")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("EmeraldLight"))
                }
            }
        }
    }

    // MARK: - Progress Bar

    private var stepProgressBar: some View {
        VStack(spacing: 8) {
            HStack {
                Text("STEP \(currentStep + 1) OF \(totalSteps)")
                    .font(.system(size: 11, weight: .heavy, design: .rounded))
                    .tracking(1.5)
                    .foregroundColor(Color("EmeraldLight"))

                Spacer()

                Text(stepTitles[currentStep])
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.12))
                        .frame(height: 4)

                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [Color("EmeraldLight"), Color(red: 0.20, green: 0.90, blue: 0.65)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * CGFloat(currentStep + 1) / CGFloat(totalSteps), height: 4)
                        .animation(.spring(response: 0.35, dampingFraction: 0.7), value: currentStep)
                }
            }
            .frame(height: 4)
        }
    }

    private var stepTitles: [String] {
        [
            "Long Press Lock Screen",
            "Tap Customize",
            "Tap Widget Slot",
            "Select Tadabbur",
            "Save & Complete"
        ]
    }

    // MARK: - Step 1: Long Press Lock Screen

    private var stepOneView: some View {
        wizardCard(
            badge: "STEP 1",
            icon: "hand.tap.fill",
            title: "Long Press Lock Screen",
            description: "Wake your iPhone. Touch and hold anywhere on an empty area of your Lock Screen until the gallery zooms out and 'Customize' appears."
        ) {
            // Visual Mockup of Step 1
            VStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )

                    VStack(spacing: 12) {
                        // Clock preview
                        Text("09:41")
                            .font(.system(size: 32, weight: .light, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))

                        // Touch pulse animation mockup
                        ZStack {
                            Circle()
                                .stroke(Color("EmeraldLight").opacity(0.3), lineWidth: 2)
                                .frame(width: 64, height: 64)

                            Circle()
                                .fill(Color("EmeraldLight").opacity(0.2))
                                .frame(width: 48, height: 48)

                            Image(systemName: "hand.point.up.fill")
                                .font(.system(size: 24))
                                .foregroundColor(Color("EmeraldLight"))
                        }

                        Text("Press & Hold Here")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color("EmeraldLight"))
                    }
                    .padding(20)
                }
                .frame(height: 200)

                tipBox(text: "💡 Make sure your iPhone is unlocked with Face ID or Touch ID first.")
            }
        }
    }

    // MARK: - Step 2: Tap Customize

    private var stepTwoView: some View {
        wizardCard(
            badge: "STEP 2",
            icon: "paintbrush.fill",
            title: "Tap 'Customize'",
            description: "Tap the Customize button at the bottom of the screen, then select the Lock Screen card on the left."
        ) {
            VStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )

                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            // Left Lock Screen (Highlighted)
                            VStack(spacing: 6) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color("EmeraldDeep"))
                                    .frame(width: 70, height: 100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color("EmeraldLight"), lineWidth: 2)
                                    )
                                    .overlay(
                                        Image(systemName: "lock.fill")
                                            .foregroundColor(.white.opacity(0.8))
                                    )
                                Text("Lock Screen")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(Color("EmeraldLight"))
                            }

                            // Right Home Screen
                            VStack(spacing: 6) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.08))
                                    .frame(width: 70, height: 100)
                                    .overlay(
                                        Image(systemName: "apps.iphone")
                                            .foregroundColor(.white.opacity(0.4))
                                    )
                                Text("Home Screen")
                                    .font(.system(size: 10, weight: .regular))
                                    .foregroundColor(.white.opacity(0.4))
                            }
                        }

                        // Customize button pill
                        HStack(spacing: 6) {
                            Image(systemName: "paintbrush")
                            Text("Customize")
                                .fontWeight(.semibold)
                        }
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color("EmeraldLight")))
                    }
                    .padding(16)
                }
                .frame(height: 200)

                tipBox(text: "Tap the Lock Screen preview on the left side to enter widget editing.")
            }
        }
    }

    // MARK: - Step 3: Tap Widget Slot

    private var stepThreeView: some View {
        wizardCard(
            badge: "STEP 3",
            icon: "plus.rectangle.dashed",
            title: "Tap the Widget Box",
            description: "Tap the rectangular dashed box directly underneath the clock. This opens the iOS Widget Gallery."
        ) {
            VStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )

                    VStack(spacing: 12) {
                        Text("09:41")
                            .font(.system(size: 34, weight: .light, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))

                        // Widget box with pulsating border
                        HStack(spacing: 8) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color("EmeraldLight"))
                            Text("Add Widgets")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("EmeraldLight"))
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color("EmeraldLight").opacity(0.15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .stroke(Color("EmeraldLight"), style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                                )
                        )
                    }
                    .padding(20)
                }
                .frame(height: 200)

                tipBox(text: "You can also tap the area directly above the clock for the compact inline verse widget.")
            }
        }
    }

    // MARK: - Step 4: Select Tadabbur

    private var stepFourView: some View {
        wizardCard(
            badge: "STEP 4",
            icon: "rectangle.badge.sparkle",
            title: "Select Tadabbur Widget",
            description: "Scroll down the list of apps and tap Tadabbur. Tap the Wide Rectangular Widget to add it below your clock."
        ) {
            VStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(Color("EmeraldLight"))
                            Text("Tadabbur Daily Ayah")
                                .font(.system(size: 13, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            Spacer()
                            Text("2×1 Wide")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(Color("EmeraldLight"))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Capsule().fill(Color("EmeraldLight").opacity(0.2)))
                        }

                        // Wide Widget Card Mockup
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Al-Fatiha · 5")
                                    .font(.system(size: 11, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("الفاتحة")
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundColor(.white)
                                    .environment(\.layoutDirection, .rightToLeft)
                            }

                            Text("إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white)
                                .environment(\.layoutDirection, .rightToLeft)
                                .frame(maxWidth: .infinity, alignment: .trailing)

                            Text("It is You we worship and You we ask for help.")
                                .font(.system(size: 10))
                                .foregroundColor(.white.opacity(0.75))
                                .lineLimit(1)
                        }
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.4))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color("EmeraldLight").opacity(0.6), lineWidth: 1)
                                )
                        )
                    }
                    .padding(16)
                }
                .frame(height: 200)

                tipBox(text: "The widget features high-contrast Arabic Uthmani calligraphy and updates every 40 minutes.")
            }
        }
    }

    // MARK: - Step 5: Save & Done

    private var stepFiveView: some View {
        wizardCard(
            badge: "STEP 5",
            icon: "checkmark.seal.fill",
            title: "Tap 'Done' to Finish",
            description: "Tap Done in the top-right corner to save your new Lock Screen. Your verses will now rotate automatically every 40 minutes!"
        ) {
            VStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )

                    VStack(spacing: 14) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 36))
                            .foregroundColor(Color("EmeraldLight"))

                        Text("You're All Set!")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Text("Every time you pick up your iPhone, a curated Quranic reflection will be waiting on your Lock Screen.")
                            .font(.system(size: 12))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.horizontal, 16)
                    }
                    .padding(20)
                }
                .frame(height: 200)

                tipBox(text: "Tap the widget anytime to jump directly into Full Reflection Mode with Nasser Al-Qatami recitation.")
            }
        }
    }

    // MARK: - Reusable Wizard Card Layout

    private func wizardCard<Content: View>(
        badge: String,
        icon: String,
        title: String,
        description: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack(spacing: 10) {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("EmeraldLight"))

                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                }

                Text(description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white.opacity(0.85))
                    .lineSpacing(4)

                // Interactive / Visual Content
                content()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
        }
    }

    private func tipBox(text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "info.circle.fill")
                .foregroundColor(Color("EmeraldLight"))
                .font(.system(size: 13))
            Text(text)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.85))
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color("EmeraldLight").opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color("EmeraldLight").opacity(0.25), lineWidth: 1)
                )
        )
    }

    // MARK: - Bottom Navigation Bar

    private var bottomNavigationBar: some View {
        HStack(spacing: 12) {
            // Previous Button
            if currentStep > 0 {
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        currentStep -= 1
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.1))
                    )
                }
                .buttonStyle(.plain)
            }

            Spacer()

            // Next / Finish Button
            Button {
                if currentStep < totalSteps - 1 {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        currentStep += 1
                    }
                } else {
                    dismiss()
                }
            } label: {
                HStack(spacing: 6) {
                    Text(currentStep == totalSteps - 1 ? "Got It!" : "Next Step")
                    Image(systemName: currentStep == totalSteps - 1 ? "checkmark" : "chevron.right")
                }
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(Color("EmeraldLight"))
                )
            }
            .buttonStyle(.plain)
        }
    }
}

// Backward-compatible alias
typealias ShortcutsGuideView = LockScreenWidgetGuideView

#Preview {
    LockScreenWidgetGuideView()
        .environmentObject(AyahStore())
}
