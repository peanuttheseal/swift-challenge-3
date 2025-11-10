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
    @State var goalTimeLeft: Int = 5
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(red: 255/255, green: 252/255, blue: 244/255)
                    .ignoresSafeArea()
                VStack{
                    NavigationLink("Goal Time Left — \(goalTimeLeft)"){
                        GoalsView(goalTimeLeft: $goalTimeLeft)
                    }
                    .foregroundStyle(.orange)
                    
                    HStack {
                        Button {
                            if isAnimationPaused == true {
                                startDate = .now
                                isAnimationPaused = false
                            } else {
                                isAnimationPaused = true
                            }
                        } label: {
                            Image(systemName: isAnimationPaused ? "play.fill" : "pause.fill")
                        }
                        .buttonStyle(.bordered)
                        .tint(Color(red: 245/255, green: 182/255, blue: 120/255))
                        
                        switch isAnimationPaused {
                        case true:
                            Text(Date.now, format: .stopwatch(startingAt: startDate ?? .now))
                        case false:
                            Text(TimeDataSource<Date>.currentDate, format: .stopwatch(startingAt: startDate ?? .now))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
