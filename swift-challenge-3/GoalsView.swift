//
//  GoalsView.swift
//  swift-challenge-3
//
//  Created by Lim Ying Hsin on 7/11/25.
//

import SwiftUI
import Combine

struct GoalsView: View {
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private let startTime: Date = Date()
    private let endTime: Double = 10
    
    @State private var elapsedTime: Double = 0.0
    
    // UI Config
    private let themeColor: Color = Color(red: 135/255, green: 207/255, blue: 237/255)
    private let circlePadding: CGFloat = 30
    
    var body: some View {
        VStack {
            Circle()
                .strokeBorder(lineWidth: 24)
                .overlay {
                    Circle()
                        .trim(from: 0.0, to: elapsedTime/endTime)
                        .stroke(themeColor, style: StrokeStyle(lineWidth: 15.0, lineCap: .square, lineJoin: .round))
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.easeInOut(duration: 1.0), value: elapsedTime)
                }
                .padding(circlePadding)
            
        }
        .onReceive(timer) { _ in
            let elapsedTime = Date().timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate
            if elapsedTime < endTime {
                self.elapsedTime = elapsedTime
            } else  {
                self.elapsedTime = endTime
            }
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
}
    
    #Preview {
        GoalsView()
    }

