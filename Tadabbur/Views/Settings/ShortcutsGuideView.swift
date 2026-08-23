import SwiftUI

// MARK: - ShortcutsGuideView

/// Interactive visual guide that explains how to configure Apple Shortcuts
/// personal automation so Tadabbur auto-opens when opening daily apps or on a schedule.
struct ShortcutsGuideView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var selectedStep = 0
    @State private var copiedName = false

    private let steps: [(number: Int, icon: String, title: String, subtitle: String, detail: String, buttonHighlight: String)] = [
        (
            1,
            "arrow.up.forward.app",
            "Open Apple Shortcuts",
            "Launch the built-in Shortcuts app",
            "Tap the 'Open Shortcuts' button below or open the Shortcuts app from your Home Screen.",
            "Open Shortcuts App"
        ),
        (
            2,
            "slider.horizontal.2.square",
            "Tap 'Automation' Tab",
            "Switch to Automations at the bottom",
            "In the bottom navigation bar of the Shortcuts app, tap the 'Automation' tab, then tap the '+' (or 'New Automation') button.",
            "Bottom Bar → Automation → +"
        ),
        (
            3,
            "app.badge.checkmark",
            "Choose 'App' (Habit Interceptor)",
            "Select which apps trigger a reflection",
            "In the trigger list, tap 'App'. Choose 'Is Opened' and pick your most frequently used apps (e.g., Safari, Social Media, or Games).",
            "Trigger: App → Is Opened"
        ),
        (
            4,
            "bolt.badge.clock.fill",
            "Set 'Run Immediately'",
            "Enable seamless auto-launching",
            "Select 'Run Immediately' and turn off 'Notify When Run' so Tadabbur opens instantly without asking each time.",
            "Select: Run Immediately"
        ),
        (
            5,
            "app.gift.fill",
            "Select Action: Open Tadabbur",
            "Choose Tadabbur as the target app",
            "Tap Next → Add Action → Search for 'Open App' → Tap 'App' and choose 'Tadabbur'. Done!",
            "Action: Open App → Tadabbur"
        )
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Hero Header
                        heroHeader

                        // Open Shortcuts & Copy Name Action Bar
                        actionButtonsBar

                        // Interactive Visual Step Carousel / Mockup
                        interactiveStepMockup

                        // Step-by-Step Checklist
                        checklistSection

                        // Alternative Methods Card
                        alternativeMethodsSection

                        Spacer(minLength: 32)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                }
            }
            .navigationTitle("Automation Setup")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .tint(Color("EmeraldLight"))
                }
            }
        }
    }

    // MARK: - Hero Header

    private var heroHeader: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color("EmeraldLight").opacity(0.15))
                    .frame(width: 72, height: 72)

                Image(systemName: "sparkles.rectangle.stack.fill")
                    .font(.system(size: 34))
                    .foregroundColor(Color("EmeraldLight"))
            }

            Text("Auto-Open Automation")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.primary)

            Text("Apple does not have a direct 'When unlocked' trigger, but you can trigger Tadabbur automatically **when opening specific apps** or on a **daily schedule**.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
        }
    }

    // MARK: - Action Buttons Bar

    private var actionButtonsBar: some View {
        VStack(spacing: 10) {
            // Main Open Shortcuts Button
            Button {
                openShortcutsWithNotificationCheatSheet()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "arrow.up.forward.app.fill")
                        .font(.headline)
                    Text("Open Shortcuts App")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "bell.badge.fill")
                        .font(.caption)
                    Text("Includes Cheat Sheet")
                        .font(.caption2.bold())
                }
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color("EmeraldLight"))
                        .shadow(color: Color("EmeraldLight").opacity(0.3), radius: 6, y: 3)
                )
            }
            .buttonStyle(.plain)

            // Copy App Name Button
            Button {
                UIPasteboard.general.string = "Tadabbur"
                copiedName = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    copiedName = false
                }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: copiedName ? "checkmark.circle.fill" : "doc.on.doc")
                        .foregroundColor(copiedName ? .green : Color("EmeraldLight"))
                    Text(copiedName ? "App name 'Tadabbur' copied to clipboard!" : "Copy App Name ('Tadabbur')")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.vertical, 6)
            }
        }
    }

    // MARK: - Interactive Visual Step Mockup

    private var interactiveStepMockup: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("VISUAL PREVIEW (STEP \(selectedStep + 1) OF \(steps.count))")
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
                Spacer()
                Text("Tap steps below")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 4)

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top, spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color("EmeraldLight"))
                            .frame(width: 44, height: 44)

                        Image(systemName: steps[selectedStep].icon)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Step \(steps[selectedStep].number): \(steps[selectedStep].title)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)

                        Text(steps[selectedStep].subtitle)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color("EmeraldLight"))
                    }
                }

                Text(steps[selectedStep].detail)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                // Highlighted Action Box
                HStack {
                    Image(systemName: "hand.tap.fill")
                        .foregroundColor(Color("EmeraldLight"))
                    Text("Target: \(steps[selectedStep].buttonHighlight)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color("EmeraldLight").opacity(0.12))
                )

                // Step Navigation Controls
                HStack {
                    Button {
                        if selectedStep > 0 {
                            withAnimation(.easeInOut) { selectedStep -= 1 }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Prev")
                        }
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(selectedStep > 0 ? Color("EmeraldLight") : .secondary.opacity(0.4))
                    }
                    .disabled(selectedStep == 0)

                    Spacer()

                    // Step Dots
                    HStack(spacing: 6) {
                        ForEach(0..<steps.count, id: \.self) { idx in
                            Circle()
                                .fill(idx == selectedStep ? Color("EmeraldLight") : Color.secondary.opacity(0.3))
                                .frame(width: idx == selectedStep ? 8 : 6, height: idx == selectedStep ? 8 : 6)
                                .onTapGesture {
                                    withAnimation(.easeInOut) { selectedStep = idx }
                                }
                        }
                    }

                    Spacer()

                    Button {
                        if selectedStep < steps.count - 1 {
                            withAnimation(.easeInOut) { selectedStep += 1 }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text("Next")
                            Image(systemName: "chevron.right")
                        }
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(selectedStep < steps.count - 1 ? Color("EmeraldLight") : .secondary.opacity(0.4))
                    }
                    .disabled(selectedStep == steps.count - 1)
                }
                .padding(.top, 4)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color(uiColor: .secondarySystemGroupedBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color("EmeraldLight").opacity(0.2), lineWidth: 1.5)
                    )
            )
        }
    }

    // MARK: - Checklist Section

    private var checklistSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("QUICK CHECKLIST")
                .font(.caption.bold())
                .foregroundColor(.secondary)
                .padding(.leading, 4)

            VStack(spacing: 10) {
                ForEach(steps.indices, id: \.self) { index in
                    let step = steps[index]
                    Button {
                        withAnimation {
                            selectedStep = index
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(selectedStep == index ? Color("EmeraldLight") : Color("EmeraldLight").opacity(0.12))
                                    .frame(width: 28, height: 28)

                                Text("\(step.number)")
                                    .font(.system(size: 13, weight: .bold, design: .rounded))
                                    .foregroundColor(selectedStep == index ? .white : Color("EmeraldLight"))
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text(step.title)
                                    .font(.system(size: 14, weight: selectedStep == index ? .bold : .medium))
                                    .foregroundColor(.primary)

                                Text(step.subtitle)
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            if selectedStep == index {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("EmeraldLight"))
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(.plain)

                    if index < steps.count - 1 {
                        Divider()
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color(uiColor: .secondarySystemGroupedBackground))
            )
        }
    }

    // MARK: - Alternative Methods Section

    private var alternativeMethodsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("POPULAR ALTERNATIVES")
                .font(.caption.bold())
                .foregroundColor(.secondary)
                .padding(.leading, 4)

            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "hand.tap")
                        .font(.title3)
                        .foregroundColor(Color("EmeraldLight"))

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Back Tap (Instant Launch)")
                            .font(.subheadline.bold())
                            .foregroundColor(.primary)
                        Text("Settings → Accessibility → Touch → Back Tap (Double Tap) → Open Tadabbur.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Divider()

                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "alarm.fill")
                        .font(.title3)
                        .foregroundColor(.orange)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Wake Up & Morning Alarm")
                            .font(.subheadline.bold())
                            .foregroundColor(.primary)
                        Text("Set trigger to 'When Alarm is Stopped' to reflect on an Ayah as soon as your morning alarm turns off.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(uiColor: .secondarySystemGroupedBackground))
            )
        }
    }

    // MARK: - Open Shortcuts & Notification Helper

    private func openShortcutsWithNotificationCheatSheet() {
        NotificationManager.shared.scheduleCheatSheetNotification()

        if let url = URL(string: "shortcuts://") {
            UIApplication.shared.open(url) { success in
                if !success {
                    if let appStoreUrl = URL(string: "https://apps.apple.com/app/shortcuts/id915249334") {
                        UIApplication.shared.open(appStoreUrl)
                    }
                }
            }
        }
    }
}

#Preview {
    ShortcutsGuideView()
}
