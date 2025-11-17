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
    
    @AppStorage("streak", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var streak: Int = 0
    
    @State private var isRunning = false
    @AppStorage("elapsedSeconds", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var elapsedSeconds: Int = 0
    @State private var timer: Timer?
    @State private var wasPausedBeforeBackground = false
    @State private var showResumeAlert = false
    @AppStorage("elapsedSeconds2", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var elapsedSeconds2: Int = 0
    @State private var changeName = false
    @AppStorage("currentStreak", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var currentstreak: Int = 0
    @State private var showingAlert = false
    @AppStorage("lastSheetDate") private var lastSheetDate: String = ""
    @State private var isSheetPresented = false
    
    @State var startDate: Date?
    @State var isAnimationPaused = true
    @State var lastUpdate: Date?
    @State var currentTime: Date?
    @AppStorage("goalTimeLeft", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var goalTimeLeft: Int = 0
    @State var action: String = "is resting"
    @AppStorage("name", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var name = "Chicken"
   
    @State var isFirstTime = true
    @State private var showContent = false
    @State var isPresented: Bool = false
    @State private var defaultValue = "Chicken"
    @State var quotes = ["Let’s get studying!", "Don’t give up!", "You got this!", "Keep going!", "Come on, study today!", "I believe in you!", "You can do it!", "Believe in yourself!", "Don’t break your streak!", "Keep up the efforts!", "Study today!", "Carpe diem :)", "Seize the day!", "Get going!", "Please don’t kill me, study today!", "Start now!", "What are you waiting for?", "No sweat — study now!", "Study. Or else :)", "What a beautiful day!", "Keep up the hard work!", "Hello!", "Start studying now!", "I have faith in you!", "Get started now!", "Keep me alive! Study now!", "I say you can do it!", "Hang in there!", "I’m proud of you!", "You’re doing a great job!", "Your hard work is paying off!", "Don’t worry, be happy!", "Nice work!", "Look how far you’ve come!", "I say you’re doing great!", "It’d be a pity not to put in any work now…", "Keep up the awesome work!", "I say do it for the brain work!", "Good evening!", "Exercise that mind, study today!", "Start studying today!", "Do study! I’d hate to have to use less…desirable methods.", "Just a little bit of effort…", "You got this! Do it for me!", "Lock in!!", "A little bit of time makes a huge difference!", "Can you reach your goal today?", "You’re doing great!", "Make me proud!", "Don’t give up on studying!", "STUDY. NOW.", "Yay!", "It’s a great day!", "Isn't this wonderful?", "Have an amazing day!", "I’m watching!", "Make that effort!", "Come on, meet your goal!", "Good afternoon!", "Don’t waste away, study today!", "Why let your brain rot?", "Hey!", "Just a few minutes away from keeping your streak!", "You’ve come this far, it’d be a pity to stop now!", "You’re doing too well to stop now!", "You can do great things with just a few minutes of study time!", "Good day!", "Have a good day!", "Be productive — start studying today!", "Do get some studying in!", "Productivity is key!", "Good morning!"]
       
    //@State var randomQuote = quotes.randomElement()

  
    let userDefaults = UserDefaults(suiteName: "group.yourbundleidentifier.streaks")!
    
    // computed property — not a stored variable — detects broken streak
    private var isStreakBroken: Bool {
        // simple rule: streak == 0 means it's broken.
        // If you prefer day-based detection, compare a saved lastStudyDay timestamp instead.
        return streak == 0
    }
    
    var body: some View {
        
        NavigationStack {
            let hours = (goalTimeLeft - elapsedSeconds2) / 3600
            let remainingSeconds = (goalTimeLeft - elapsedSeconds2) % 3600
            let minutes = remainingSeconds / 60
            let seconds = remainingSeconds % 60
            VStack {
                
                // streak
                Text("🔥 \(streak) day streak")
                
                let quotes = ["Let’s get studying!", "Don’t give up!", "You got this!", "Keep going!", "Come on, study today!", "I believe in you!", "You can do it!", "Believe in yourself!", "Don’t break your streak!", "Keep up the efforts!", "Study today!", "Carpe diem :)", "Seize the day!", "Get going!", "Please don’t kill me, study today!", "Start now!", "What are you waiting for?", "No sweat — study now!", "Study. Or else :)", "What a beautiful day!", "Keep up the hard work!", "Hello!", "Start studying now!", "I have faith in you!", "Get started now!", "Keep me alive! Study now!", "\(name) says you can do it!", "Hang in there!", "I’m proud of you!", "You’re doing a great job!", "Your hard work is paying off!", "Don’t worry, be happy!", "Nice work!", "Look how far you’ve come!", "\(name) says you’re doing great!", "It’d be a pity not to put in any work now…", "Keep up the awesome work!", "\(name) says do it for the brain work!", "Good evening!", "Exercise that mind, study today!", "Start studying today!", "Just a little bit of effort…", "You got this! Do it for me!", "Lock in!!", "A little bit of time makes a huge difference!", "Can you reach your goal today?", "You’re doing great!", "Make me proud!", "Don’t give up on studying!", "STUDY. NOW.", "Yay!", "It’s a great day!", "Isn't this wonderful?", "Have an amazing day!", "I’m watching!", "Make that effort!", "Come on, meet your goal!", "Good afternoon!", "Don’t waste away, study today!", "Why let your brain rot?", "Hey!", "Just a few minutes away from keeping your streak!", "You’ve come this far, it’d be a pity to stop now!", "You’re doing too well to stop now!", "Good day!", "Have a good day!", "Be productive — start studying today!", "Do get some studying in!", "Productivity is key!", "Good morning!"]
                if let randomQuote = quotes.randomElement() {                    
                    if isRunning == false {
                        Text("\(randomQuote)")
                    }
                }
                
                
                
                // chicken animation
                // <- MODIFIED: when isStreakBroken is true, show ChickenCookedView
                if isStreakBroken {
                    // show the cooked chicken when the streak is broken
                    StudyCookedView(name: "ChickenCooked")
                        .frame(width: 300, height: 500)
                        .padding()
                } else {
                    // original behavior when streak is not broken
                    if isRunning {
                        StudyView(name: "ChickenStudy")
                            .frame(width: 300, height: 300)
                            .padding()
                    } else {
                        RestView(name: "ChickenRest")
                            .frame(width: 300, height: 300)
                            .padding()
                    }
                }
                
                // change chicken name
                HStack {
                    Button(action: {
                        changeName.toggle()
                    }) {
                        Text(name)
                            .foregroundStyle(.orange)
                    }
                    .font(.title2)
                    .sheet(isPresented: $changeName, onDismiss: didDismiss) {
                        VStack {
                            Text("Change Name:")
                                .font(.title)
                            
                            Text("You can click the chicken's name to edit it again")
                            
                            TextField("New Name", text: $name)
                                .textFieldStyle(.roundedBorder)
                            
                            Button("Done",action: {
                                isPresented = false
                                changeName.toggle()
                                if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    showingAlert = true
                                }
                                else {
                                    print("Input is not blank/empty")
                                }
                                
                            })
                        }
                        .padding()
                        .onDisappear{
                            let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            if trimmed.isEmpty {
                                name = defaultValue
                            } else {
                                defaultValue = name
                            }
                            
                        }
                    }
                }
                
                Text(action)
                    .font(.title2)
                
                // button to go to study goal time
                NavigationLink(goalTimeLeft - elapsedSeconds2 <= 0 ? "Goal Time Finished!" : "Goal Time Left: \n  \(hours)h \(minutes)m \(seconds)s") {
                    GoalsView(elapsedSeconds2: $elapsedSeconds2, goalTimeLeft: $goalTimeLeft)
                }
                .font(.title2)
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
                            action = "is resting"
                            
                        } else {
                            isRunning = true
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            elapsedSeconds += 1
                            elapsedSeconds2 += 1
                            action = "is studying"
                            
                            }
                        }
                        
                        if isFirstTime == true {
                            streak += 1
                            userDefaults.set(streak, forKey: "streakCount")
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
                        .font(.system(size: 40, weight: .medium))
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
                    streak = userDefaults.integer(forKey: "streakCount")
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
            let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"   // only the date, no time
                
                let today = formatter.string(from: Date())
                
                if lastSheetDate != today {
                    // first time opening app today
                    isSheetPresented = true
                    lastSheetDate = today
                }
        }
    }
    
    func quoteTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            //Text(randomQuote)
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
    

