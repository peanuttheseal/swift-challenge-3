//
//  StreakWidget.swift
//  StreakWidget
//
//  Created by T Krobot on 15/11/25.
//

import WidgetKit
import SwiftUI
import AppIntents
import Network

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), streakCount: 0) // Placeholder for initial display
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.peanuttheseal.swift-challenge-3.streaks")!
        let streak = userDefaults.integer(forKey: "streakCount")
        let entry = SimpleEntry(date: Date(), streakCount: streak)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.peanuttheseal.swift-challenge-3.streaks")!
        let streak = userDefaults.integer(forKey: "streakCount")
        let entry = SimpleEntry(date: Date(), streakCount: streak)

        let timeline = Timeline(entries: [entry], policy: .atEnd) // Update when needed
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let streakCount: Int
}

struct StreakWidgetEntryView : View {
    @AppStorage("currentStreak", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var streak: Int = 0
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("🔥🐓   S T R E A K   🐓🔥")
                .font(.headline)
            Text("\(streak) days!")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

@main
struct StreakWidget: Widget {
    let kind: String = "StreakWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            StreakWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Streak Counter")
        .description("Displays your current streak.")
    }
}


#Preview(as: .systemSmall) {
    StreakWidget()
} timeline: {
    SimpleEntry(date: .now, streakCount: 0)
}
