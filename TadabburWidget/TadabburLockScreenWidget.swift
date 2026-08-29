import WidgetKit
import SwiftUI

// MARK: - Timeline Entry

struct AyahTimelineEntry: TimelineEntry {
    let date: Date
    let ayah: Ayah
}

// MARK: - Timeline Provider (40-Minute Rotation)

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

        // Rotate verses every 40 minutes across a 24-hour timeline window (36 slots)
        for slot in 0..<36 {
            guard let entryDate = Calendar.current.date(byAdding: .minute, value: slot * 40, to: currentDate) else { continue }
            let ayahIndex = slot % catalog.count
            let entry = AyahTimelineEntry(date: entryDate, ayah: catalog[ayahIndex])
            entries.append(entry)
        }

        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 8, to: currentDate) ?? currentDate.addingTimeInterval(3600 * 8)
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
            FuturisticMountainMediumView(ayah: entry.ayah)
                .widgetURL(URL(string: "tadabbur://reflect"))

        case .systemLarge:
            FuturisticMountainLargeView(ayah: entry.ayah)
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
            // Header Row: Reference & Futuristic Sparkle
            HStack(spacing: 4) {
                Image(systemName: "sparkles")
                    .font(.system(size: 9, weight: .bold))
                Text(ayah.reference)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                Spacer()
                Text(ayah.surahNameArabic)
                    .font(.system(size: 10, weight: .semibold))
                    .environment(\.layoutDirection, .rightToLeft)
            }

            // Arabic text (High contrast bold Uthmani)
            Text(ayah.arabicText)
                .font(.system(size: 13, weight: .bold, design: .serif))
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .environment(\.layoutDirection, .rightToLeft)
                .frame(maxWidth: .infinity, alignment: .trailing)

            // English translation excerpt
            Text(ayah.translation)
                .font(.system(size: 10, weight: .medium))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .opacity(0.85)
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
            Text("✨ \(ayah.surahName) \(ayah.ayahNumber) · \(ayah.translation)")
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
                    .font(.system(size: 13))
                Text("تدبر")
                    .font(.system(size: 8.5, weight: .bold))
                Text("\(ayah.ayahNumber)")
                    .font(.system(size: 8, weight: .semibold, design: .rounded))
            }
        }
    }
}

// MARK: - 4. Mountain Silhouette & Aurora Futuristic Landscape Background

struct MountainAuroraBackground: View {
    var body: some View {
        ZStack {
            // Deep obsidian / cyber-emerald sky gradient
            LinearGradient(
                colors: [
                    Color(red: 0.02, green: 0.06, blue: 0.10), // Obsidian Navy
                    Color(red: 0.03, green: 0.15, blue: 0.12), // Deep Pine
                    Color(red: 0.01, green: 0.05, blue: 0.08)  // Midnight Base
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Luminous Aurora Borealis Wave (Top-Right Glow)
            RadialGradient(
                colors: [
                    Color(red: 0.18, green: 0.85, blue: 0.58).opacity(0.35),
                    Color(red: 0.10, green: 0.60, blue: 0.80).opacity(0.15),
                    .clear
                ],
                center: .topTrailing,
                startRadius: 10,
                endRadius: 280
            )

            // Starry Constellation Dots
            GeometryReader { geo in
                let w = geo.size.width
                let h = geo.size.height

                Circle().fill(Color.white.opacity(0.7)).frame(width: 2, height: 2).position(x: w * 0.15, y: h * 0.12)
                Circle().fill(Color.white.opacity(0.4)).frame(width: 1.5, height: 1.5).position(x: w * 0.35, y: h * 0.08)
                Circle().fill(Color.white.opacity(0.8)).frame(width: 2.5, height: 2.5).position(x: w * 0.72, y: h * 0.18)
                Circle().fill(Color.white.opacity(0.5)).frame(width: 1.5, height: 1.5).position(x: w * 0.88, y: h * 0.10)
                Circle().fill(Color.white.opacity(0.6)).frame(width: 2, height: 2).position(x: w * 0.50, y: h * 0.22)
            }

            // Mountain Layer 1 (Back Distant Ridge)
            MountainRidgeShape(peaks: [0.35, 0.18, 0.40, 0.25, 0.45, 0.20, 0.38])
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.06, green: 0.24, blue: 0.20).opacity(0.5),
                            Color(red: 0.02, green: 0.10, blue: 0.12).opacity(0.8)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            // Mountain Layer 2 (Foreground Sharp Ridge with Neon Crest)
            MountainRidgeShape(peaks: [0.55, 0.38, 0.60, 0.42, 0.65, 0.48, 0.58])
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.02, green: 0.09, blue: 0.10),
                            Color(red: 0.01, green: 0.04, blue: 0.06)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(
                    MountainRidgeLine(peaks: [0.55, 0.38, 0.60, 0.42, 0.65, 0.48, 0.58])
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.31, green: 0.90, blue: 0.60).opacity(0.5),
                                    Color(red: 0.10, green: 0.60, blue: 0.80).opacity(0.3),
                                    .clear
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 1
                        )
                )
        }
    }
}

// Custom Mountain Polygon Shape
struct MountainRidgeShape: Shape {
    let peaks: [CGFloat]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let step = rect.width / CGFloat(peaks.count - 1)
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height * (1.0 - peaks[0])))

        for i in 1..<peaks.count {
            let x = CGFloat(i) * step
            let y = rect.height * (1.0 - peaks[i])
            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct MountainRidgeLine: Shape {
    let peaks: [CGFloat]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let step = rect.width / CGFloat(peaks.count - 1)
        path.move(to: CGPoint(x: 0, y: rect.height * (1.0 - peaks[0])))

        for i in 1..<peaks.count {
            let x = CGFloat(i) * step
            let y = rect.height * (1.0 - peaks[i])
            path.addLine(to: CGPoint(x: x, y: y))
        }
        return path
    }
}

// MARK: - 5. Largest Futuristic Mountain Widget (systemLarge)

struct FuturisticMountainLargeView: View {
    let ayah: Ayah

    var body: some View {
        ZStack {
            // Mountain Landscape & Aurora
            MountainAuroraBackground()

            // High-Contrast Content Container
            VStack(spacing: 14) {
                // Top Futuristic Header
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "moon.stars.fill")
                            .foregroundColor(Color(red: 0.35, green: 0.95, blue: 0.65))
                            .font(.system(size: 13, weight: .bold))
                        Text("TADABBUR")
                            .font(.system(size: 11, weight: .heavy, design: .rounded))
                            .tracking(2)
                            .foregroundColor(Color(red: 0.35, green: 0.95, blue: 0.65))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color(red: 0.35, green: 0.95, blue: 0.65).opacity(0.16))
                            .overlay(
                                Capsule().stroke(Color(red: 0.35, green: 0.95, blue: 0.65).opacity(0.35), lineWidth: 1)
                            )
                    )

                    Spacer()

                    // Reference Badge
                    Text(ayah.reference)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white.opacity(0.12))
                        )
                }

                Spacer(minLength: 0)

                // Arabic Verse (Crystal-Clear High Contrast Calligraphy)
                Text(ayah.arabicText)
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .lineSpacing(9)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.8), radius: 6, x: 0, y: 3)
                    .environment(\.layoutDirection, .rightToLeft)
                    .padding(.horizontal, 6)

                // Futuristic Neo-Emerald Divider
                HStack(spacing: 8) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.clear, Color(red: 0.35, green: 0.95, blue: 0.65).opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 1)

                    Image(systemName: "sparkle")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(Color(red: 0.35, green: 0.95, blue: 0.65))

                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [Color(red: 0.35, green: 0.95, blue: 0.65).opacity(0.7), .clear],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 1)
                }
                .padding(.horizontal, 28)

                // English Translation (Crisp High-Contrast Typography)
                Text(ayah.translation)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.92))
                    .lineSpacing(4)
                    .shadow(color: Color.black.opacity(0.8), radius: 4, x: 0, y: 2)
                    .padding(.horizontal, 6)

                Spacer(minLength: 0)

                // Bottom Callout Card
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(Color(red: 0.35, green: 0.95, blue: 0.65))
                            .font(.system(size: 14))
                        Text("Sheikh Nasser Al-Qatami")
                            .font(.system(size: 11, weight: .semibold, design: .rounded))
                            .foregroundColor(.white.opacity(0.85))
                    }

                    Spacer()

                    Text(ayah.arabicReference)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(red: 0.35, green: 0.95, blue: 0.65))
                        .environment(\.layoutDirection, .rightToLeft)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.black.opacity(0.35))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                        )
                )
            }
            .padding(16)
        }
    }
}

// MARK: - 6. Futuristic Mountain Medium Widget (systemMedium)

struct FuturisticMountainMediumView: View {
    let ayah: Ayah

    var body: some View {
        ZStack {
            MountainAuroraBackground()

            VStack(alignment: .leading, spacing: 6) {
                // Top row
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(Color(red: 0.35, green: 0.95, blue: 0.65))
                        Text(ayah.reference)
                            .font(.system(size: 11.5, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.35, green: 0.95, blue: 0.65))
                    }
                    Spacer()
                    Text(ayah.surahNameArabic)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .environment(\.layoutDirection, .rightToLeft)
                }

                // Arabic Verse
                Text(ayah.arabicText)
                    .font(.system(size: 15, weight: .bold, design: .serif))
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.8), radius: 4, x: 0, y: 2)
                    .environment(\.layoutDirection, .rightToLeft)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                // Translation
                Text(ayah.translation)
                    .font(.system(size: 11, weight: .medium))
                    .lineLimit(2)
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: Color.black.opacity(0.8), radius: 3, x: 0, y: 1)
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
        .description("Display inspiring Quranic verses on your Lock Screen and Home Screen, rotating every 40 minutes.")
        .supportedFamilies([
            .accessoryRectangular,  // Largest iPhone Lock Screen size
            .accessoryInline,       // Above clock on Lock Screen
            .accessoryCircular,     // Circular lock screen slot
            .systemMedium,          // iPad Lock Screen & Home Screen
            .systemLarge            // Largest iPad Lock Screen & Home Screen size
        ])
    }
}
