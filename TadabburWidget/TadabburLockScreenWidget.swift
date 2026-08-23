import WidgetKit
import SwiftUI

// MARK: - Timeline Entry

struct AyahTimelineEntry: TimelineEntry {
    let date: Date
    let ayah: Ayah
}

// MARK: - Timeline Provider

struct AyahTimelineProvider: TimelineProvider {
    typealias Entry = AyahTimelineEntry

    func placeholder(in context: Context) -> AyahTimelineEntry {
        AyahTimelineEntry(date: Date(), ayah: Ayah.catalog[0])
    }

    func getSnapshot(in context: Context, completion: @escaping (AyahTimelineEntry) -> Void) {
        let entry = AyahTimelineEntry(date: Date(), ayah: Ayah.catalog[0])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<AyahTimelineEntry>) -> Void) {
        var entries: [AyahTimelineEntry] = []
        let currentDate = Date()
        let catalog = Ayah.catalog

        // Create timeline entries rotating verses every 30 minutes
        for hourOffset in 0..<12 {
            guard let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset * 30, to: currentDate) else { continue }
            let ayahIndex = (hourOffset) % catalog.count
            let entry = AyahTimelineEntry(date: entryDate, ayah: catalog[ayahIndex])
            entries.append(entry)
        }

        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 6, to: currentDate) ?? currentDate.addingTimeInterval(3600 * 6)
        let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
        completion(timeline)
    }
}

// MARK: - Main Widget Entry View

struct TadabburWidgetEntryView: View {
    var entry: AyahTimelineProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .accessoryRectangular:
            AccessoryRectangularView(ayah: entry.ayah)
                .widgetURL(URL(string: "tadabbur://reflect"))

        case .accessoryInline:
            AccessoryInlineView(ayah: entry.ayah)
                .widgetURL(URL(string: "tadabbur://reflect"))

        case .accessoryCircular:
            AccessoryCircularView(ayah: entry.ayah)
                .widgetURL(URL(string: "tadabbur://reflect"))

        case .systemMedium:
            SystemMediumView(ayah: entry.ayah)
                .widgetURL(URL(string: "tadabbur://reflect"))

        case .systemLarge:
            SystemLargeView(ayah: entry.ayah)
                .widgetURL(URL(string: "tadabbur://reflect"))

        default:
            AccessoryRectangularView(ayah: entry.ayah)
                .widgetURL(URL(string: "tadabbur://reflect"))
        }
    }
}

// MARK: - 1. Largest iPhone Lock Screen Widget (accessoryRectangular)

struct AccessoryRectangularView: View {
    let ayah: Ayah

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            // Header Row: Reference & Icon
            HStack(spacing: 4) {
                Image(systemName: "sparkles")
                    .font(.system(size: 10, weight: .bold))
                Text(ayah.reference)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                Spacer()
                Text(ayah.surahNameArabic)
                    .font(.system(size: 10, weight: .medium))
                    .environment(\.layoutDirection, .rightToLeft)
            }
            .foregroundColor(.primary)

            // Arabic text (Primary focus)
            Text(ayah.arabicText)
                .font(.system(size: 13, weight: .bold, design: .serif))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .environment(\.layoutDirection, .rightToLeft)
                .frame(maxWidth: .infinity, alignment: .trailing)

            // English translation excerpt
            Text(ayah.translation)
                .font(.system(size: 10.5, weight: .regular))
                .lineLimit(2)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

// MARK: - 2. Lock Screen Inline Widget (accessoryInline)

struct AccessoryInlineView: View {
    let ayah: Ayah

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "sparkle")
            Text("\(ayah.surahName) \(ayah.ayahNumber) · \(ayah.translation)")
        }
    }
}

// MARK: - 3. Lock Screen Circular Widget (accessoryCircular)

struct AccessoryCircularView: View {
    let ayah: Ayah

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack(spacing: 1) {
                Image(systemName: "moon.stars.fill")
                    .font(.system(size: 14))
                Text("تدبر")
                    .font(.system(size: 9, weight: .bold))
                Text("\(ayah.ayahNumber)")
                    .font(.system(size: 8, weight: .semibold, design: .rounded))
            }
        }
    }
}

// MARK: - 4. Largest iPad Lock Screen & Home Screen Widget (systemLarge)

struct SystemLargeView: View {
    let ayah: Ayah

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                colors: [Color(red: 0.04, green: 0.22, blue: 0.16), Color(red: 0.05, green: 0.10, blue: 0.18)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 16) {
                // Top Header Badge
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "moon.stars.fill")
                            .foregroundColor(Color(red: 0.31, green: 0.78, blue: 0.47))
                            .font(.subheadline)
                        Text("TADABBUR")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .tracking(1.5)
                            .foregroundColor(Color(red: 0.31, green: 0.78, blue: 0.47))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color(red: 0.31, green: 0.78, blue: 0.47).opacity(0.18))
                    )

                    Spacer()

                    Text(ayah.reference)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                }

                Spacer(minLength: 0)

                // Arabic Verse
                Text(ayah.arabicText)
                    .font(.system(size: 22, weight: .semibold, design: .serif))
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .foregroundColor(.white)
                    .environment(\.layoutDirection, .rightToLeft)
                    .padding(.horizontal, 8)

                // Ornamental Divider
                HStack(spacing: 8) {
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 1)
                    Image(systemName: "sparkle")
                        .font(.caption2)
                        .foregroundColor(Color(red: 0.31, green: 0.78, blue: 0.47))
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 1)
                }
                .padding(.horizontal, 24)

                // English Translation
                Text(ayah.translation)
                    .font(.system(size: 14, weight: .regular))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.85))
                    .lineSpacing(4)
                    .padding(.horizontal, 8)

                Spacer(minLength: 0)

                // Bottom Callout
                HStack {
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(Color(red: 0.31, green: 0.78, blue: 0.47))
                    Text("Tap to reflect & listen")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                    Text(ayah.arabicReference)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white.opacity(0.5))
                        .environment(\.layoutDirection, .rightToLeft)
                }
            }
            .padding(18)
        }
    }
}

// MARK: - 5. System Medium Widget (systemMedium)

struct SystemMediumView: View {
    let ayah: Ayah

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.04, green: 0.22, blue: 0.16), Color(red: 0.05, green: 0.10, blue: 0.18)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(ayah.reference)
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.31, green: 0.78, blue: 0.47))
                    Spacer()
                    Text(ayah.surahNameArabic)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                        .environment(\.layoutDirection, .rightToLeft)
                }

                Text(ayah.arabicText)
                    .font(.system(size: 15, weight: .bold, design: .serif))
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .environment(\.layoutDirection, .rightToLeft)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                Text(ayah.translation)
                    .font(.system(size: 11.5, weight: .regular))
                    .lineLimit(2)
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding(14)
        }
    }
}

// MARK: - Lock Screen Widget Configuration

@main
struct TadabburLockScreenWidget: Widget {
    let kind: String = "TadabburLockScreenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AyahTimelineProvider()) { entry in
            if #available(iOS 17.0, *) {
                TadabburWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TadabburWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Tadabbur Daily Ayah")
        .description("Display Quranic verses on your Lock Screen and Home Screen for instant reflection.")
        .supportedFamilies([
            .accessoryRectangular,  // Largest iPhone Lock Screen size
            .accessoryInline,       // Above clock on Lock Screen
            .accessoryCircular,     // Circular lock screen slot
            .systemMedium,          // iPad Lock Screen & Home Screen
            .systemLarge            // Largest iPad Lock Screen & Home Screen size
        ])
    }
}
