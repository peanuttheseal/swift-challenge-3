//
//  SheetView.swift
//  swift-challenge-3
//
//  Created by Sophie Tjhi on 10/11/25.
//

import SwiftUI

struct SheetView: View {
    
        @Binding var isPresented: Bool
    @State private var selectedHour = 00
    let hours = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    @State private var selectedMinute = 00
    let minutes = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]

        var body: some View {
            VStack {
                Text("Set your daily time goal!")
                    .font(.title)
                    .padding()
                    .monospaced()
                HStack {
                    Spacer()
                    Text("You won’t see this popup again. You can edit your goal in Settings.")
                        .font(.title3)
                        .padding()
                        .monospaced()
                    Spacer()
                }
            }
            
            Section{
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
                }
            }
        }
    }
