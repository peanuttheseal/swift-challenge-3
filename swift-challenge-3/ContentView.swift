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
    @State private var isSheetPresented = false
    @State private var isRunning = false
    @State private var elapsedSeconds = 0
    @State private var timer: Timer?
    @State var name: String = "Chicken"
    @State var action: String = "is resting"
    @State var text = ""

    var body: some View {
        NavigationStack {
            VStack {
              
                RestView(name: "ChickenRest")
                    .frame(width: 300, height: 300)
                    .padding()
                
                HStack {
                    Button(action: {
                        changeName.toggle()
                    }) {
                        Text(name)
                    }
                    .monospaced()
                    .font(.title2)
                    .sheet(isPresented: $changeName, onDismiss: didDismiss) {
                        VStack {
                            Text("Change Name:")
                                .font(.title)

                            Text("You can click the chicken's name to edit it again")

                            TextField("New Name", text: $text)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding()
                    }
                }

                Text(action)
                    .monospaced()
                    .font(.title2)
            
                NavigationLink("Goal Time Left — \(goalTimeLeft)") {
                    GoalsView(goalTimeLeft: $goalTimeLeft)
                }
                .font(.title2)
                .bold()
                .foregroundStyle(.orange)
                .padding()
                .background(.black.opacity(0.1))
                .cornerRadius(30)

                HStack {
                    Button {
                        if isRunning {
                            timer?.invalidate()
                            timer = nil
                            isRunning = false
                        } else {
                            isRunning = true
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                elapsedSeconds += 1
                            }
                        }
                    } label: {
                        Image(systemName: isRunning ? "pause.fill" : "play.fill")
                            .font(.title)
                    }
                    .buttonStyle(.bordered)
                    .tint(Color(red: 245/255, green: 182/255, blue: 120/255))

                    Text(timeString(from: elapsedSeconds))
                        .font(.system(size: 40, weight: .medium, design: .monospaced))
                }
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetView(isPresented: $isSheetPresented)
        }
        .onAppear {
            isSheetPresented = true
        }
    }

    func timeString(from seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }

    func didDismiss() {}
}


#Preview {
    ContentView()
}
