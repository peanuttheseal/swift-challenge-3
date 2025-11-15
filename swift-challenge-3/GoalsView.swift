//
//  GoalsView.swift
//  swift-challenge-3
//
//  Created by Lim Ying Hsin on 7/11/25.
//

import SwiftUI

struct GoalsView: View {
    @State private var isShowingSheet = false
    @Binding var elapsedSeconds2: Int
    @Binding var goalTimeLeft: Int
    
    // UI Config
    private let themeColor2: Color = Color(red: 245/255, green: 183/255, blue: 120/255)
    private let themeColor1: Color = Color(red: 252/255, green: 227/255, blue: 172/255)
    private let circlePadding: CGFloat = 50.0
    
    var body: some View {
        VStack{
            Text("Time Goal:")
                .monospaced()
                .font(.title)
            ZStack{
                Text("Time left: \(goalTimeLeft - elapsedSeconds2)")
                    .monospaced()
                    .font(.title)
                Circle()
                    .stroke(themeColor1, style: StrokeStyle(lineWidth: 35.0, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: 270))
                    .padding(circlePadding)
                Circle()
                    .trim(from: 0, to: Double(elapsedSeconds2)/Double(goalTimeLeft))
                    .stroke(themeColor2, style: StrokeStyle(lineWidth: 35.0, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.easeOut, value: goalTimeLeft < 0 ? 1: elapsedSeconds2)
                    .padding(circlePadding)
            }
        }
    }
}
