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
    @State private var changeName = false

    
    var body: some View {
        NavigationStack {
            ZStack{
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
        
        Button(action: {
            changeName.toggle()
               }) {
                   Text("Show License Agreement")
               }
               .sheet(isPresented: $changeName,
                      onDismiss: didDismiss) {
                   VStack {
                       Text("Change Name:")
                           .font(.title)
                           .padding(50)
                       Text("You can click the chicken's name to edit it again")
                           .padding(50)
                       Button("Close",
                              action: { changeName.toggle() })
                   }
               }
           }


           func didDismiss() {
               // Handle the dismissing action.
           }
    }
#Preview {
    ContentView()
}
