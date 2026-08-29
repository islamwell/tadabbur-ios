import SwiftUI

// MARK: - SettingsView

/// App settings: overlay toggle, pause duration, notification toggle.
struct SettingsView: View {

    @EnvironmentObject private var settingsStore: SettingsStore
    @EnvironmentObject private var ayahStore: AyahStore

    @State private var testNotificationSent = false
    @State private var showWidgetWizard = false
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
                            Text("Daily Ayah Reminders")
                                .font(.body)
                            Text("Receive curated Quranic verses on your Lock Screen")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .tint(Color("EmeraldLight"))
                    .onChange(of: settingsStore.notificationEnabled) { enabled in
                        handleNotificationToggle(enabled: enabled)
                    }

                    if settingsStore.notificationEnabled {
                        // Frequency (1 to 5 times per day)
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Daily Frequency")
                                    .font(.body)
                                Spacer()
                                Text("\(settingsStore.dailyNotificationCount)× per day")
                                    .font(.subheadline.bold())
                                    .foregroundColor(Color("EmeraldLight"))
                            }

                            Picker("Frequency", selection: $settingsStore.dailyNotificationCount) {
                                Text("1×").tag(1)
                                Text("2×").tag(2)
                                Text("3×").tag(3)
                                Text("4×").tag(4)
                                Text("5×").tag(5)
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: settingsStore.dailyNotificationCount) { _ in
                                rescheduleDailyNotifications()
                            }
                        }
                        .padding(.vertical, 4)

                        // Schedule Mode (Evenly Spaced vs Custom Specific Times)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Schedule Mode")
                                .font(.caption.bold())
                                .foregroundColor(.secondary)

                            Picker("Schedule Mode", selection: $settingsStore.notificationScheduleMode) {
                                ForEach(NotificationScheduleMode.allCases) { mode in
                                    Text(mode.rawValue).tag(mode)
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: settingsStore.notificationScheduleMode) { _ in
                                rescheduleDailyNotifications()
                            }
                        }
                        .padding(.vertical, 4)

                        // Mode A: Evenly Spaced Options
                        if settingsStore.notificationScheduleMode == .evenlySpaced {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Active Hours Range")
                                        .font(.subheadline)
                                    Spacer()
                                    Text("\(formatHour(settingsStore.dayStartHour)) – \(formatHour(settingsStore.dayEndHour))")
                                        .font(.subheadline.monospacedDigit())
                                        .foregroundColor(.secondary)
                                }

                                HStack(spacing: 12) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Starts: \(formatHour(settingsStore.dayStartHour))")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Stepper("", value: $settingsStore.dayStartHour, in: 4...12)
                                            .labelsHidden()
                                    }

                                    Spacer()

                                    VStack(alignment: .trailing, spacing: 4) {
                                        Text("Ends: \(formatHour(settingsStore.dayEndHour))")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Stepper("", value: $settingsStore.dayEndHour, in: 18...23)
                                            .labelsHidden()
                                    }
                                }
                                .onChange(of: settingsStore.dayStartHour) { _ in rescheduleDailyNotifications() }
                                .onChange(of: settingsStore.dayEndHour) { _ in rescheduleDailyNotifications() }

                                // Computed Times Preview Pills
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("SCHEDULED REMINDER TIMES:")
                                        .font(.caption2.bold())
                                        .foregroundColor(.secondary)

                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 8) {
                                            ForEach(Array(settingsStore.targetNotificationTimes().enumerated()), id: \.offset) { idx, time in
                                                HStack(spacing: 4) {
                                                    Image(systemName: "clock.fill")
                                                        .font(.system(size: 9))
                                                    Text(formatTimeHourMin(time.hour, time.minute))
                                                        .font(.caption.bold())
                                                }
                                                .foregroundColor(Color("EmeraldLight"))
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 6)
                                                .background(
                                                    Capsule()
                                                        .fill(Color("EmeraldLight").opacity(0.12))
                                                        .overlay(Capsule().stroke(Color("EmeraldLight").opacity(0.25), lineWidth: 1))
                                                )
                                            }
                                        }
                                    }
                                }
                                .padding(.top, 4)
                            }
                            .padding(.vertical, 4)
                        }

                        // Mode B: Custom Times DatePickers
                        if settingsStore.notificationScheduleMode == .customTimes {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("SPECIFY EXACT REMINDER TIMES:")
                                    .font(.caption2.bold())
                                    .foregroundColor(.secondary)

                                ForEach(0..<settingsStore.dailyNotificationCount, id: \.self) { idx in
                                    HStack {
                                        HStack(spacing: 6) {
                                            Image(systemName: "\(idx + 1).circle.fill")
                                                .foregroundColor(Color("EmeraldLight"))
                                            Text("Reminder \(idx + 1)")
                                                .font(.subheadline)
                                        }

                                        Spacer()

                                        DatePicker(
                                            "",
                                            selection: customTimeBinding(for: idx),
                                            displayedComponents: .hourAndMinute
                                        )
                                        .labelsHidden()
                                        .onChange(of: settingsStore.customNotificationTimes) { _ in
                                            rescheduleDailyNotifications()
                                        }
                                    }
                                    .padding(.vertical, 2)
                                }
                            }
                            .padding(.vertical, 4)
                        }

                        // Test Notification Button
                        Button {
                            sendTestNotification()
                        } label: {
                            HStack {
                                Image(systemName: "bell.badge.fill")
                                    .foregroundColor(Color("EmeraldLight"))
                                Text(testNotificationSent ? "Scheduled in 3s! (Lock Screen Now)" : "Send Test Lock Screen Notification (3s)")
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                        }

                        // Deep link to system notification settings
                        Button {
                            openNotificationSettings()
                        } label: {
                            HStack {
                                Text("Open iOS Notification Settings")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "arrow.up.right")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }

                } header: {
                    sectionHeader("Notifications")
                } footer: {
                    Text("Configure 1 to 5 daily notifications with rotating verses. Lock your device after tapping 'Send Test Notification' to see the Lock Screen banner.")
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

                        Text("Tadabbur features high-contrast, beautiful Lock Screen widgets rotating every 40 minutes, plus iPad & Home Screen widgets.")
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

                        // Interactive Wizard Launch Button
                        Button {
                            showWidgetWizard = true
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "wand.and.stars")
                                    .font(.subheadline.weight(.semibold))
                                Text("Open Step-by-Step Widget Wizard")
                                    .font(.subheadline.weight(.semibold))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption2)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color("EmeraldLight"))
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 6)
                } header: {
                    sectionHeader("Lock Screen Widgets")
                } footer: {
                    Text("Tap the button above for an interactive visual guide on adding the widget to your Lock Screen.")
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
            .sheet(isPresented: $showWidgetWizard) {
                LockScreenWidgetGuideView()
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

    private func handleNotificationToggle(enabled: Bool) {
        if enabled {
            NotificationManager.shared.requestAuthorization { granted in
                if granted {
                    NotificationManager.shared.scheduleDailyNotifications(from: settingsStore)
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

    private func rescheduleDailyNotifications() {
        guard settingsStore.notificationEnabled else { return }
        NotificationManager.shared.scheduleDailyNotifications(from: settingsStore)
    }

    private func customTimeBinding(for index: Int) -> Binding<Date> {
        Binding(
            get: {
                if index < settingsStore.customNotificationTimes.count {
                    return settingsStore.customNotificationTimes[index]
                }
                return Date()
            },
            set: { newDate in
                var times = settingsStore.customNotificationTimes
                while times.count <= index {
                    times.append(Date())
                }
                times[index] = newDate
                settingsStore.customNotificationTimes = times
            }
        )
    }

    private func formatHour(_ hour: Int) -> String {
        let h = hour % 24
        let ampm = h >= 12 ? "PM" : "AM"
        let displayH = h % 12 == 0 ? 12 : h % 12
        return "\(displayH):00 \(ampm)"
    }

    private func formatTimeHourMin(_ hour: Int, _ min: Int) -> String {
        let h = hour % 24
        let ampm = h >= 12 ? "PM" : "AM"
        let displayH = h % 12 == 0 ? 12 : h % 12
        return String(format: "%d:%02d %@", displayH, min, ampm)
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
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.3"
        return "v\(version) (updated 2026-08-29 07:15)"
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsStore())
        .environmentObject(AyahStore())
}
