//
//  ContentView.swift
//  swift-challenge-3
//
//  Created by T Krobot on 5/11/25.
//

import SwiftUI
struct ContentView : View {
    @State var startDate: Date? // Stores when the user presses the start button
        @State var isAnimationPaused = true // Flag to control the animation update schedule
        @State var lastUpdate: Date? // Stores the date of the last update on screen

        var body: some View {
            switch isAnimationPaused {
            case true:
                // By using a static `Date` value, the view will be static
                // Using the `startDate` or Date.now fallback allows the stopwatch to pause and
                // continue to display the duration
                Text(Date.now, format: .stopwatch(startingAt: startDate ?? .now))
            case false:
                // Using a `TimeDataSource`, the view will animate
                Text(TimeDataSource<Date>.currentDate, format: .stopwatch(startingAt: startDate ?? .now))
            }
            HStack {
                Button("Start") {
                    // Store the moment at which the user presses the Start button
                    startDate = .now
                    // Unpause the TimelineView's animation schedule
                    isAnimationPaused = false
                }
                .buttonStyle(.bordered)
                .tint(.green)
                .disabled(isAnimationPaused == false)
                Button("Stop") {
                    // We only pause the animation schedule to stop the
                    isAnimationPaused = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .disabled(isAnimationPaused)
            }
        }
}

#Preview {
    ContentView()
}
