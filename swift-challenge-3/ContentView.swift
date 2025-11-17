//
//  ContentView.swift
//  swift-challenge-3
//
//  Created by T Krobot on 5/11/25.
//

import SwiftUI
import WidgetKit
struct ContentView : View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("currentStreak", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var currentStreak: Int = 0
    
    @State private var isRunning = false
    @State private var elapsedSeconds: Int = 0
    @State private var timer: Timer?
    @State private var wasPausedBeforeBackground = false
    @State private var showResumeAlert = false
    @State private var elapsedSeconds2: Int = 0
    
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
    
    @State private var showingAlert = false
    
    let userDefaults = UserDefaults(suiteName: "group.yourbundleidentifier.streaks")!
    
    var body: some View {
        NavigationStack {
            let hours = (goalTimeLeft - elapsedSeconds2) / 3600
                   let remainingSeconds = (goalTimeLeft - elapsedSeconds2) % 3600
                   let minutes = remainingSeconds / 60
                   let seconds = remainingSeconds % 60
            VStack {
                
                // streak
                Text("\(streak) days")
                    .monospaced()
                
                var quotes = ["Let’s get studying!", "Don’t give up!", "You got this!", "Keep going!", "Come on, study today!", "I believe in you!", "You can do it!", "Believe in yourself!", "Don’t break your streak!", "Keep up the efforts!", "Study today!", "Carpe diem :)", "Seize the day!", "Get going!", "Please don’t kill me, study today!", "Start now!", "What are you waiting for?", "No sweat — study now!", "Study. Or else :)", "What a beautiful day!", "Keep up the hard work!", "Hello!", "Start studying now!", "I have faith in you!", "Get started now!", "Keep me alive! Study now!", "\(name) says you can do it!", "Hang in there!", "I’m proud of you!", "You’re doing a great job!", "Your hard work is paying off!", "Don’t worry, be happy!", "Nice work!", "Look how far you’ve come!", "\(name) says you’re doing great!", "It’d be a pity not to put in any work now…", "Keep up the awesome work!", "\(name)  says do it for the brain work!", "Good evening!", "Exercise that mind, study today!", "Start studying today!", "Do study! I’d hate to have to use less…desirable methods.", "Just a little bit of effort…", "You got this! Do it for me!", "Lock in!!", "A little bit of time makes a huge difference!", "Can you reach your goal today?", "You’re doing great!", "Make me proud!", "Don’t give up on studying!", "STUDY. NOW.", "Yay!", "It’s a great day!", "Isn't this wonderful?", "Have an amazing day!", "I’m watching!", "Make that effort!", "Come on, meet your goal!", "Good afternoon!", "Don’t waste away, study today!", "Why let your brain rot?", "Hey!", "Just a few minutes away from keeping your streak!", "You’ve come this far, it’d be a pity to stop now!", "You’re doing too well to stop now!", "You can do great things with just a few minutes of study time!", "Good day!", "Have a good day!", "Be productive — start studying today!", "Do get some studying in!", "Productivity is key!", "Good morning!"]
                if let randomQuote = quotes.randomElement() {
                    Text("\(randomQuote)")
                    
                }
                
                // chicken animation
                
                if isRunning {
                    StudyView(name: "ChickenStudy")
                        .frame(width: 300, height: 300)
                        .padding()
                } else {
                    RestView(name: "ChickenRest")
                        .frame(width: 300, height: 300)
                        .padding()
                }
                
                // change chicken name
                HStack {
                    Button(action: {
                        changeName.toggle()
                        showingAlert = true
                    }) {
                        Text(name)
                            .foregroundStyle(.orange)
                    }
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
                    .alert(isPresented: $showingAlert) {
                        if name.isEmpty {
                            Alert(title: Text("Important message"), message: Text("This cannot be left blank"), dismissButton: .default(Text("Got it!")))
                        }
                        else {
                            Alert(title: Text("Nil"), message: Text("Nil"), dismissButton: .default(Text("Nil")))
                        }
                    }
                }
                
                Text(action)
                    .monospaced()
                    .font(.title2)
                
                // button to go to study goal time
                NavigationLink("Goal Time Left: \n  \(hours)h \(minutes)m \(seconds)s") {
                    GoalsView(elapsedSeconds2: $elapsedSeconds2, goalTimeLeft: $goalTimeLeft)
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
                                elapsedSeconds2 += 1
                            }
                        }
                        
                        if isFirstTime == true {
                            streak += 1
                            userDefaults.set(currentStreak, forKey: "streakCount")
                                            WidgetCenter.shared.reloadAllTimelines()
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
                .onAppear {
                            currentStreak = userDefaults.integer(forKey: "streakCount")
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
