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
    @State var currentTime: Date?

        var body: some View {
            switch isAnimationPaused {
            case true:
                Text(Date.now, format: .stopwatch(startingAt: startDate ?? .now))
            case false:
                Text(TimeDataSource<Date>.currentDate, format: .stopwatch(startingAt: startDate ?? .now))
            }
            HStack {
                Button(isAnimationPaused ? "Start" : "Stop") {
                    
                    if isAnimationPaused == true {
                        isAnimationPaused = false
                    } else {
                        isAnimationPaused = true
                    }
                    
                    
                }
                .buttonStyle(.bordered)
                .tint(isAnimationPaused ? .green : .red)
                
            }
        }
}

#Preview {
    ContentView()
}
