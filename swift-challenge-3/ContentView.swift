//
//  ContentView.swift
//  swift-challenge-3
//
//  Created by T Krobot on 5/11/25.
//

import SwiftUI
struct ContentView : View {
    @State var startDate: Date?
        @State var isAnimationPaused = true
        @State var lastUpdate: Date?

        var body: some View {
            switch isAnimationPaused {
            case true:
                Text(Date.now, format: .stopwatch(startingAt: startDate ?? .now))
            case false:
                Text(TimeDataSource<Date>.currentDate, format: .stopwatch(startingAt: startDate ?? .now))
            }
            HStack {
                Button("Start") {
                    startDate = .now
                    isAnimationPaused = false
                }
                .buttonStyle(.bordered)
                .tint(.green)
                .disabled(isAnimationPaused == false)
                Button("Stop") {
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
