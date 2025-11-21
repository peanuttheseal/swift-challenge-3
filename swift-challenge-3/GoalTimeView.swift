//
//  SheetView.swift
//  swift-challenge-3
//
//  Created by Sophie Tjhi on 10/11/25.
//

import SwiftUI

struct GoalTimeView: View {
    @Binding var goalTime: Int
    @Binding var isPresented: Bool
    @Binding var goalTimeLeft: Int
    @State private var selectedHour = 00
    @State private var selectedMinute = 00
    let hours = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    let minutes = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]
    
    func selectedTime(){
        goalTime = selectedHour * 3600 + selectedMinute * 60
        goalTimeLeft = goalTime
        print("Goal Time: \(goalTime)")
        print(goalTimeLeft)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Set your daily time goal!")
                    .font(.title)
                    .padding()
                
                Text("You can edit this in Goals.")
                    .font(.title3)
                    .padding([.leading, .trailing], 50)
                    .padding(.bottom,20)
                
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
                    
                    VStack{
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
                }
            }
            .navigationTitle("Set your time goal!")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        selectedTime()
                        isPresented = false
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}
