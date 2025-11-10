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
    
    @State private var isShowingSheet = false
    
    // UI Config
    private let themeColor: Color = Color(red: 245/255, green: 183/255, blue: 120/255)
    private let circlePadding: CGFloat = 30
    
    var body: some View {
        ZStack{
            Color(red: 255/255, green: 252/255, blue: 244/255)
                .ignoresSafeArea()
            VStack {
                Circle()
                    .trim(from: 0.0, to: elapsedTime/endTime)
                    .stroke(themeColor, style: StrokeStyle(lineWidth: 28.0, lineCap: .round, lineJoin: .round))
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
        
        Button(action: {
            isShowingSheet.toggle()
        }) {
            Text("Show License Agreement")
        }
        .sheet(isPresented: $isShowingSheet,
               onDismiss: didDismiss) {
            VStack {
                Text("License Agreement")
                    .font(.title)
                    .padding(50)
                Text("""
                        Terms and conditions go here.
                    """)
                    .padding(50)
                Button("Dismiss",
                       action: { isShowingSheet.toggle() })
            }
        }
    }


    func didDismiss() {
        // Handle the dismissing action.
    }
}


#Preview {
    GoalsView()
}

