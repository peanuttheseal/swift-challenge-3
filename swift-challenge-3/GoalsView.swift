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
    
    @Binding var goalTimeLeft: Int
    
    // UI Config
    private let themeColor2: Color = Color(red: 245/255, green: 183/255, blue: 120/255)
    private let themeColor1: Color = Color(red: 252/255, green: 227/255, blue: 172/255)
    private let circlePadding: CGFloat = 50.0
    
    //Timer Change
    @State private var selectedHour = 00
    let hours = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    @State private var selectedMinute = 00
    let minutes = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]

    
    func selectedTime(){
        goalTimeLeft = selectedHour * 60 + selectedMinute
    }
    
    var body: some View {
        VStack{
            Text("Time Goal:")
                .monospaced()
                .font(.title)
            ZStack{
                Text("Time left: \(goalTimeLeft)")
                    .monospaced()
                    .font(.title)
                Circle()
                    .stroke(themeColor1, style: StrokeStyle(lineWidth: 35.0, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: 270))
                    .padding(circlePadding)
                Circle()
                    .trim(from: 0.0, to: elapsedTime/endTime)
                    .stroke(themeColor2, style: StrokeStyle(lineWidth: 35.0, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.easeInOut(duration: 1.0), value: elapsedTime)
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
        Button(action: {
            isShowingSheet.toggle()
        }) {
            Text("Change Time Goal")
        }
        .font(.title)
        .monospaced()
        .buttonStyle(.bordered)
        .sheet(isPresented: $isShowingSheet,
               onDismiss: didDismiss){
            VStack {
                Text("Time Goal:")
                    .font(.title)
                    .monospaced()
                    .padding(50)
                
                HStack{
                    VStack{
                        Text("Hours")
                            .font(.system(size:25))
                            .bold()
                        
                        Picker("Hours", selection: $selectedHour)
                        {
                            ForEach (hours, id: \.self) {
                                Text(String(format:"%02d", $0))
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    VStack {
                        Text("Minutes")
                            .font(.system(size:25))
                            .bold()
                        
                        Picker("Mintues", selection: $selectedMinute){
                            ForEach(minutes, id: \.self){
                                Text(String(format: "%02d", $0))
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    .onChange(of: selectedHour) {
                        selectedTime()
                    }
                    
                    .onChange(of: selectedMinute) {
                        selectedTime()
                    }
                }

            }
        }
    }
    
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}
