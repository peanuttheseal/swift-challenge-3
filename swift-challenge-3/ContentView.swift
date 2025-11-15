//
//  ContentView.swift
//  swift-challenge-3
//
//  Created by T Krobot on 5/11/25.
//

import SwiftUI
struct ContentView : View {
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isRunning = false
    @State private var elapsedSeconds:Int = 0
    @State private var timer: Timer?
    @State private var wasPausedBeforeBackground = false
    @State private var showResumeAlert = false
    
    @State var startDate: Date?
    @State var isAnimationPaused = true
    @State var lastUpdate: Date?
    @State var currentTime: Date?
    @State var goalTimeLeft: Int
    @State private var changeName = false
    @State private var isSheetPresented = false
    @State var action: String = "is resting"
    @State var name = "Chicken"
    @State var streak: Int = 0
    @State var isFirstTime = true
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // streak
                Text("\(streak) days")
                    .monospaced()
                
                // chicken animation
                RestView(name: "ChickenRest")
                    .frame(width: 300, height: 300)
                    .padding()
                
                // change chicken name
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
                                .monospaced()
                            
                            Text("You can click the chicken's name to edit it again")
                                .monospaced()
                            
                            TextField("New Name", text: $name)
                                .textFieldStyle(.roundedBorder)
                                .monospaced()
                            
                            Button("Done",
                                   action: { changeName.toggle() })
                        }
                        .padding()
                    }
                }
                
                Text(action)
                    .monospaced()
                    .font(.title2)
                
                // button to go to study goal time
                NavigationLink("Goal Time Left: \(goalTimeLeft)") {
                    GoalsView(elapsedSeconds: $elapsedSeconds, goalTimeLeft: $goalTimeLeft)
                }
                .font(.title2)
                .monospaced()
                .bold()
                .foregroundStyle(.orange)
                .padding()
                .background(.black.opacity(0.1))
                .cornerRadius(30)
                
                // timer
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
                        
                        if isFirstTime == true {
                            streak += 1
                            isFirstTime = false
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
                .onChange(of: scenePhase) {
                    if scenePhase == .background {
                        if !isRunning && elapsedSeconds > 0 {
                            wasPausedBeforeBackground = true
                        }
                    }
                    if scenePhase == .active {
                        if wasPausedBeforeBackground {
                            showResumeAlert = true
                            wasPausedBeforeBackground = false
                        }
                    }
                }
                .alert("Continue study session?", isPresented: $showResumeAlert) {
                    Button("Continue") {
                        startTimer()
                    }
                    Button("End Session", role: .destructive) {
                        elapsedSeconds = 0
                        isRunning = false
                    }
                }
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            GoalTimeView(isPresented: $isSheetPresented, goalTimeLeft: $goalTimeLeft)
        }
        .onAppear {
            isSheetPresented = true
        }
    }
    
    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in elapsedSeconds += 1
        }
    }
    
    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
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
    ContentView(goalTimeLeft: 5)
}
