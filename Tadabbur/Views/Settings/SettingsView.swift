import SwiftUI

// MARK: - SettingsView

/// App settings: overlay toggle, pause duration, notification toggle.
struct SettingsView: View {

    @EnvironmentObject private var settingsStore: SettingsStore
    @EnvironmentObject private var ayahStore: AyahStore

    @State private var testNotificationSent = false
    @State private var showShortcutsGuide = false
    @State private var alertMessage = ""
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            List {
                // MARK: Current Verse Section
                Section {
                    AyahPreviewCard(ayah: ayahStore.currentAyah)
                        .padding(.vertical, 8)
                } header: {
                    sectionHeader("Current Verse")
                }

                // MARK: Reflection Section
                Section {
                    // Overlay toggle
                    Toggle(isOn: $settingsStore.overlayEnabled) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Reflection Overlay")
                                .font(.body)
                            Text("Show full-screen verse when you open or unlock to app")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .tint(Color("EmeraldLight"))

                    // Pause duration slider
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Pause Duration")
                                .font(.body)
                            Spacer()
                            Text("\(settingsStore.pauseDuration)s")
                                .font(.body.monospacedDigit())
                                .foregroundColor(.secondary)
                        }

                        Slider(
                            value: Binding(
                                get: { Double(settingsStore.pauseDuration) },
                                set: { settingsStore.pauseDuration = Int($0.rounded()) }
                            ),
                            in: 3...30,
                            step: 1
                        )
                        .tint(Color("EmeraldLight"))
                        .disabled(!settingsStore.overlayEnabled)

                        HStack {
                            Text("3s")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("30s")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                    .opacity(settingsStore.overlayEnabled ? 1 : 0.4)

                } header: {
                    sectionHeader("Reflection")
                } footer: {
                    Text("How long before the Continue button appears in the overlay.")
                        .font(.caption)
                }

                // MARK: Notifications Section
                Section {
                    Toggle(isOn: $settingsStore.notificationEnabled) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Ayah Reminders")
                                .font(.body)
                            Text("Lock screen notification every 30 minutes")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .tint(Color("EmeraldLight"))
                    .onChange(of: settingsStore.notificationEnabled) { enabled in
                        handleNotificationToggle(enabled: enabled)
                    }

                    // Test Notification Button
                    Button {
                        sendTestNotification()
                    } label: {
                        HStack {
                            Image(systemName: "bell.badge.fill")
                                .foregroundColor(Color("EmeraldLight"))
                            Text(testNotificationSent ? "Notification Scheduled in 3s! (Lock Screen Now)" : "Send Test Lock Screen Notification (3s)")
                                .foregroundColor(.primary)
                            Spacer()
                        }
                    }

                    // Deep link to system notification settings
                    Button {
                        openNotificationSettings()
                    } label: {
                        HStack {
                            Text("Notification Settings")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }

                } header: {
                    sectionHeader("Notifications")
                } footer: {
                    Text("Tap 'Send Test Lock Screen Notification' then press Cmd+L (Lock Screen) in the simulator to see the lock screen reminder.")
                        .font(.caption)
                }

                // MARK: Lock Screen Widgets Section
                Section {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Label("Lock Screen Widget", systemImage: "rectangle.badge.sparkle")
                                .font(.headline)
                                .foregroundColor(Color("EmeraldLight"))
                            Spacer()
                            Text("Largest Size")
                                .font(.caption2.bold())
                                .foregroundColor(Color("EmeraldLight"))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Capsule().fill(Color("EmeraldLight").opacity(0.15)))
                        }

                        Text("Tadabbur supports the largest possible rectangular Lock Screen widget (2x1 wide slot directly below the clock), plus large Home Screen & iPad widgets.")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        // Live Widget Preview Card
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 4) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 10, weight: .bold))
                                Text(ayahStore.currentAyah.reference)
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                Spacer()
                                Text(ayahStore.currentAyah.surahNameArabic)
                                    .font(.system(size: 11, weight: .medium))
                                    .environment(\.layoutDirection, .rightToLeft)
                            }
                            .foregroundColor(.primary)

                            Text(ayahStore.currentAyah.arabicText)
                                .font(.system(size: 13.5, weight: .bold, design: .serif))
                                .lineLimit(1)
                                .environment(\.layoutDirection, .rightToLeft)
                                .frame(maxWidth: .infinity, alignment: .trailing)

                            Text(ayahStore.currentAyah.translation)
                                .font(.system(size: 11, weight: .regular))
                                .lineLimit(2)
                                .foregroundColor(.secondary)
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color(uiColor: .tertiarySystemGroupedBackground))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .stroke(Color("EmeraldLight").opacity(0.3), lineWidth: 1)
                                )
                        )

                        // Step-by-step how to add
                        VStack(alignment: .leading, spacing: 6) {
                            Text("HOW TO ADD TO LOCK SCREEN:")
                                .font(.caption2.bold())
                                .foregroundColor(.secondary)

                            HStack(alignment: .top, spacing: 6) {
                                Text("1.")
                                    .font(.caption.bold())
                                    .foregroundColor(Color("EmeraldLight"))
                                Text("Long press on your **iPhone Lock Screen** and tap **Customize**.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            HStack(alignment: .top, spacing: 6) {
                                Text("2.")
                                    .font(.caption.bold())
                                    .foregroundColor(Color("EmeraldLight"))
                                Text("Tap the **Lock Screen** preview, then tap the widget area under the clock.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            HStack(alignment: .top, spacing: 6) {
                                Text("3.")
                                    .font(.caption.bold())
                                    .foregroundColor(Color("EmeraldLight"))
                                Text("Select **Tadabbur** and choose the wide rectangular widget.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.vertical, 6)
                } header: {
                    sectionHeader("Lock Screen Widgets")
                }

                // MARK: Automations Section
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Label("Automations & Habit Interceptor", systemImage: "sparkles")
                                .font(.headline)
                                .foregroundColor(Color("EmeraldLight"))
                            Spacer()
                        }

                        Text("Automatically bring up Tadabbur before opening daily apps (e.g. Safari, Social Media) or on a schedule using Apple Shortcuts.")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        // Open Shortcuts App Button
                        Button {
                            openShortcutsApp()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.up.forward.app.fill")
                                    .font(.subheadline)
                                Text("Open Shortcuts App")
                                    .font(.subheadline.weight(.semibold))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color("EmeraldLight"))
                            )
                        }
                        .buttonStyle(.plain)

                        // View Full Guide Button
                        Button {
                            showShortcutsGuide = true
                        } label: {
                            HStack {
                                Image(systemName: "list.bullet.rectangle.portrait.fill")
                                    .foregroundColor(Color("EmeraldLight"))
                                Text("View Visual Step-by-Step Guide")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 4)
                        }
                    }
                    .padding(.vertical, 6)
                } header: {
                    sectionHeader("Shortcuts Automations")
                } footer: {
                    Text("Takes less than 1 minute to set up in the Shortcuts app.")
                        .font(.caption)
                }

                // MARK: About Section
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(appVersion)
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Verses")
                        Spacer()
                        Text("\(Ayah.catalog.count) ayahs")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    sectionHeader("About")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showShortcutsGuide) {
                ShortcutsGuideView()
            }
            .alert("Notification Permission", isPresented: $showAlert) {
                Button("Open Settings") {
                    openNotificationSettings()
                }
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }

    // MARK: Helpers

    private func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .textCase(nil)
    }

    private func openShortcutsApp() {
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

    private func handleNotificationToggle(enabled: Bool) {
        if enabled {
            NotificationManager.shared.requestAuthorization { granted in
                if granted {
                    NotificationManager.shared.scheduleRepeatingNotification(
                        for: ayahStore.currentAyah
                    )
                } else {
                    // Permission denied — revert toggle and notify user
                    settingsStore.notificationEnabled = false
                    alertMessage = "Please allow notification permissions in iOS Settings so Tadabbur can show verses on your lock screen."
                    showAlert = true
                }
            }
        } else {
            NotificationManager.shared.cancelAll()
        }
    }

    private func openNotificationSettings() {
        guard let url = URL(string: UIApplication.openNotificationSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

    private func sendTestNotification() {
        NotificationManager.shared.scheduleTestNotification(for: ayahStore.currentAyah, delaySeconds: 3) { success, errorMsg in
            if success {
                testNotificationSent = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    testNotificationSent = false
                }
            } else if let errorMsg = errorMsg {
                alertMessage = errorMsg
                showAlert = true
            }
        }
    }

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsStore())
        .environmentObject(AyahStore())
}
