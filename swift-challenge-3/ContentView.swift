//
//  ContentView.swift
//  swift-challenge-3
//
//  Created by T Krobot on 5/11/25.
//

import SwiftUI
struct StopWatchButton : View {
    var actions: [() -> Void]
    var labels: [String]
    var color: Color
    var isPaused: Bool
    
    var body: some View {
        let buttonWidth = (UIScreen.main.bounds.size.width / 2) - 12
        
        return Button(action: {
            if self.isPaused {
                self.actions[0]()
            } else {
                self.actions[1]()
            }
        }) {
            if isPaused {
                Text(self.labels[0])
                    .foregroundStyle(.white)
                    .frame(width: buttonWidth,
                           height: 50)
            } else {
                Text(self.labels[1])
                    .foregroundStyle(.white)
                    .frame(width: buttonWidth,
                           height: 50)
            }
        }
        .background(self.color)
    }
}
struct ContentView : View {
    @StateObject var stopWatch = StopWatch()
    
    var body: some View {
        VStack {
            Text(self.stopWatch.stopWatchTime)
                .font(.custom("courier", size: 70))
                .frame(width: UIScreen.main.bounds.size.width,
                       height: 300,
                       alignment: .center)
            
            HStack{
                StopWatchButton(actions: [self.stopWatch.reset, self.stopWatch.lap],
                                labels: ["Reset", "Lap"],
                                color: Color.red,
                                isPaused: self.stopWatch.isPaused())
                StopWatchButton(actions: [self.stopWatch.start, self.stopWatch.pause],
                                labels: ["Start", "Pause"],
                                color: Color.blue,
                                isPaused: self.stopWatch.isPaused())
            }
            VStack(alignment: .leading) {
                Text("Laps")
                    .font(.title)
                    .padding()
                List {
                    ForEach(self.stopWatch.laps, id: \.uuid) { (lapItem) in
                        Text(lapItem.stringTime)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
