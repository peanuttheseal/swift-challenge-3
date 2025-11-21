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
    @State private var changeGoalTime = false
    
    // UI Config
    private let themeColor2: Color = Color(red: 245/255, green: 183/255, blue: 120/255)
    private let themeColor1: Color = Color(red: 252/255, green: 227/255, blue: 172/255)
    private let circlePadding: CGFloat = 50.0
    
    @Binding var goalTime: Int
    @State var isPresented2: Bool = false
    @State private var selectedHour = 00
    @State private var selectedMinute = 00
    let hours2 = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    let minutes2 = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]
    
    func selectedTime(){
        goalTime = selectedHour * 3600 + selectedMinute * 60
        goalTimeLeft = goalTime
        print("Goal Time: \(goalTime)")
        print(goalTimeLeft)
    }
    
    
    var body: some View {
        let hours = (goalTimeLeft - elapsedSeconds2) / 3600
        let remainingSeconds = (goalTimeLeft - elapsedSeconds2) % 3600
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        
        let hours10 = (goalTime) / 3600
        let minutes10 = goalTime % 3600 / 60
        let seconds10 = goalTime % 60
        
        VStack{
            
            Text("Goal Time: \(hours10)h \(minutes10)m \(seconds10)s")
            
            ZStack{
                VStack{
                    Text("Time left:")
                        .font(.title)
                    
                    Text(goalTimeLeft - elapsedSeconds2 <= 0 ? "Goal Met!!" : "\(hours)h \(minutes)m \(seconds)s")
                        .font(.title)
                }
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
        Button (action: {
            changeGoalTime.toggle() }) {
                Text("Change Time Goal")
                    .font(.title2)
                    .foregroundColor(.orange)
            }
            .padding()
            .background(.black.opacity(0.1))
            .cornerRadius(30)
            .sheet(isPresented: $changeGoalTime , onDismiss: didDismiss){
                VStack {
                    Text("Change time goal:")
                        .font(.title)
                        .bold()
                        .padding()
                    Text("Goal Time: \(hours10)h \(minutes10)m \(seconds10)s")
                        .padding()
                    HStack {
                        VStack{
                            Text("Hours")
                                .font(.system(size:25))
                                .bold()
                            
                            Picker("Hours", selection: $selectedHour)
                            {
                                ForEach (hours2, id: \.self) {
                                    Text(String(format:"%02d", $0))
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        
                        VStack{
                            Text("Minutes")
                                .font(.system(size:25))
                                .bold()
                            
                            Picker("Mintues", selection: $selectedMinute){
                                ForEach(minutes2, id: \.self){
                                    Text(String(format: "%02d", $0))
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
                    Button {
                        selectedTime()
                        isPresented2 = false
                        changeGoalTime = false
                    } label: {
                        HStack{
                            Image(systemName: "checkmark.circle")
                                .font(.title)
                            Text("Done")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                }
                .onAppear {
                        let total = goalTimeLeft
                        selectedHour = total / 3600
                        selectedMinute = (total % 3600) / 60
                    }

            }
    }
    
    
}

func didDismiss() {}

