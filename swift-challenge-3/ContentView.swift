//
//  ContentView.swift
//  swift-challenge-3
//
//  Created by T Krobot on 5/11/25.
//

import SwiftUI
import WidgetKit
struct ContentView : View {
    @State var goalTime : Int
    
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("elapsedSeconds", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var elapsedSeconds: Int = 0
    @AppStorage("elapsedSeconds2", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var elapsedSeconds2: Int = 0
    @AppStorage("currentStreak", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var currentstreak: Int = 0
    @AppStorage("lastSheetDate") private var lastSheetDate: String = ""
    @AppStorage("name", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var name = "Chicken"
    @AppStorage("goalTimeLeft", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm")) var goalTimeLeft: Int = 0
    @AppStorage("isFirstTime") private var isFirstTime = true
    @AppStorage("lastResetDate", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm"))
    private var lastResetDate: String = ""
    
    @State private var appWasInBackground = false
    
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var wasPausedBeforeBackground = false
    @State private var showResumeAlert = false
    @State private var changeName = false
    @State private var showingAlert = false
    @State private var isSheetPresented = false
    
    @AppStorage("streak", store: UserDefaults(suiteName: "group.sg.tk.2025.4pm"))
    private var streak = 0
    @AppStorage("tapDate") var TapDate: String?
    @AppStorage("Tappable") var ButtonTapped = false
    
    //@State var startDate: Date?
    @State private var showContent = false
    @State private var defaultValue = "Chicken"
    
    @State var startDate: Date?
    @State var isAnimationPaused = true
    @State var lastUpdate: Date?
    @State var currentTime: Date?
    @State var action: String = "is resting"
    @State var isPresented: Bool = false
    @State var lastTimerStart: Calendar
    
    @State private var inputText: String = ""
    let characterLimit: Int = 20
    
    @State var quotes = ["Let’s get studying!", "Don’t give up!", "You got this!", "Keep going!", "Come on, study today!", "I believe in you!", "You can do it!", "Believe in yourself!", "Don’t break your streak!", "Keep up the efforts!", "Study today!", "Carpe diem :)", "Seize the day!", "Get going!", "Please don’t kill me, study today!", "Start now!", "What are you waiting for?", "No sweat — study now!", "Study. Or else :)", "What a beautiful day!", "Keep up the hard work!", "Hello!", "Start studying now!", "I have faith in you!", "Get started now!", "Keep me alive! Study now!", "I say you can do it!", "Hang in there!", "I’m proud of you!", "You’re doing a great job!", "Your hard work is paying off!", "Don’t worry, be happy!", "Nice work!", "Look how far you’ve come!", "I say you’re doing great!", "Keep up the awesome work!", "I say do it for the brain work!", "Good evening!", "Exercise that mind, study today!", "Start studying today!", "Do study! I’d hate to have to use less…desirable methods.", "Just a little bit of effort…", "You got this! Do it for me!", "Lock in!!", "A little bit of time makes a huge difference!", "Can you reach your goal today?", "You’re doing great!", "Make me proud!", "Don’t give up on studying!", "STUDY. NOW.", "Yay!", "It’s a great day!", "Isn't this wonderful?", "Have an amazing day!", "I’m watching!", "Make that effort!", "Come on, meet your goal!", "Good afternoon!", "Don’t waste away, study today!", "Why let your brain rot?", "Hey!", "You’ve come this far, it’d be a pity to stop now!", "You’re doing too well to stop now!", "Good day!", "Have a good day!", "Be productive — start studying today!", "Do get some studying in!", "Productivity is key!", "Good morning!"]
    
    
    //@State var randomQuote = quotes.randomElement()
    
    
    let userDefaults = UserDefaults(suiteName: "group.sg.tk.2025.4pm")!
    
    // computed property — not a stored variable — detects broken streak
    private var isStreakBroken: Bool {
        // simple rule: streak == 0 means it's broken.
        // If you prefer day-based detection, compare a saved lastStudyDay timestamp instead.
        return streak == 0
    }
    
    // Timer Reset Everyday Logic
    func resetIfNewDay() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = formatter.string(from: Date())
        
        // If never saved before → collect it and don't reset
        if lastResetDate.isEmpty {
            lastResetDate = today
            return
        }
        
        // If date changed → it's a new day → reset timer
        if lastResetDate != today {
            elapsedSeconds = 0
            elapsedSeconds2 = 0
            isRunning = false
            lastResetDate = today
        }
    }
    
    var body: some View {
        
        GeometryReader{ geo in
            NavigationStack {
                let hours = (goalTimeLeft - elapsedSeconds2) / 3600
                let remainingSeconds = (goalTimeLeft - elapsedSeconds2) % 3600
                let minutes = remainingSeconds / 60
                let seconds = remainingSeconds % 60
                HStack {
                    Image(systemName: "flame.fill")
                        .resizable()
                        .frame(width: 16, height: 20)
                        .scaledToFit()
                        .background(Color.white)
                        .foregroundColor(ButtonTapped ? Color.orange : Color.gray)
                        .cornerRadius(12)
                    // streak
                    Text(" \(streak) day streak")
                        .bold()
                        .font(.title3)
                }
                
                
                
                VStack {
                    
                    
                    if let randomQuote = quotes.randomElement() {
                        Text(isRunning ? " " : randomQuote)
                            .frame(minHeight: 20) // Reserve space even when empty
                            .opacity(isRunning ? 0 : 1) // Fade out instead of removing
                    }
                    
                    ZStack {
                        // chicken animation
                        // <- MODIFIED: when isStreakBroken is true, show ChickenCookedView
                        if isStreakBroken {
                            // show the cooked chicken when the streak is broken
                            StudyCookedView(name: "ChickenCooked")
                                .frame(width: geo.size.width * 0.7, height: geo.size.width * 0.73)
                                .disabled(true)
                                .allowsHitTesting(false)
                            
                        } else {
                            // original behavior when streak is not broken
                            if isRunning {
                                StudyView(name: "ChickenStudy")
                                    .frame(width: geo.size.width * 0.7, height: geo.size.width * 0.73)         .disabled(true)
                                    .allowsHitTesting(false)
                            } else {
                                
                                if goalTimeLeft - elapsedSeconds2 <= 0 {
                                    Image("ChickenWithHat")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geo.size.width * 0.7, height: geo.size.width * 0.73)
                                        .disabled(true)
                                        .allowsHitTesting(false)
                                        .opacity (isRunning ? 0 : 1)
                                } else {
                                    RestView(name: "ChickenRest").frame(width: geo.size.width * 0.7, height: geo.size.width * 0.73)
                                        .disabled(true)
                                        .allowsHitTesting(false)
                                }
                                
                            }
                            
                            //                            if goalTimeLeft - elapsedSeconds2 <= 0 {
                            //                                Image("ChickenPartyHat")
                            //                                    .resizable()
                            //                                    .scaledToFit()
                            //                                    .frame(width: 70, height: 152)
                            //                                    .padding(.top,12)
                            //                                    .disabled(true)
                            //                                    .allowsHitTesting(false)
                            //                                    .opacity (1)
                            //
                            //                            }
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
                            NavigationStack {
                                VStack {
                                    Text("You can click the chicken's name to edit it again")
                                        .font(.title2)
                                    
                                    TextField("New Name", text: $name)
                                        .font(.title2)
                                        .textFieldStyle(.roundedBorder)
                                        .onChange(of: name) { newValue in
                                            if newValue.count > characterLimit {
                                                name = String(newValue.prefix(characterLimit))
                                            }
                                        }
                                }
                                .navigationTitle("Change name")
                                .toolbar {
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button {
                                            isPresented = false
                                            changeName.toggle()
                                            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                                showingAlert = true
                                            }
                                            else {
                                                print("Input is not blank/empty")
                                            }
                                        } label: {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                                .padding()
                                .tint(.orange)
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
                    }
                }
                
                Text(action)
                    .font(.title2)
                
                // button to go to study goal time
                NavigationLink(goalTimeLeft - elapsedSeconds2 <= 0 ? "Goal Time Finished!" : "Goal Time Left: \n  \(hours)h \(minutes)m \(seconds)s") {
                    GoalsView(elapsedSeconds2: $elapsedSeconds2, goalTimeLeft: $goalTimeLeft, goalTime: $goalTime)
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
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            lastResetDate = formatter.string(from: Date())
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                elapsedSeconds += 1
                                elapsedSeconds2 += 1
                                action = "is studying"
                            }
                        }
                        if  TapDate == nil {
                            //Check if user has already tapped
                            self.ButtonTapped = true
                            streak += 1
                            self.TapDate = ("\(Date.getTomDate())")
                        }
                        else if ("\(Date.getTodayDate())") == TapDate {
                            //Check for the consecutive Day of Streak
                            
                            self.TapDate = ("\(Date.getTomDate())")
                            streak += 1
                            //Let's light the flame back again.
                            self.ButtonTapped = true
                        }
                    }
                    label: {
                        Image(systemName: isRunning ? "pause.fill" : "play.fill")
                            .font(.title)
                    }
                    .buttonStyle(.bordered)
                    .tint(Color(red: 245/255, green: 182/255, blue: 120/255))
                    
                    Text(timeString(from: elapsedSeconds))
                        .font(.system(size: 40, weight: .medium))
                }
                .onAppear {
                    if ("\(Date.getTodayDate())") == TapDate ||
                        ("\(Date.getTomDate())") == TapDate {
                        self.ButtonTapped = true
                    }
                    //Breaking the Streak
                    else {
                        self.TapDate = nil
                        self.ButtonTapped = false
                        self.streak = 0
                    }
                    
                }
                .onChange(of: scenePhase) {
                    if scenePhase == .background {
                        if !isRunning && elapsedSeconds > 0 {
                            wasPausedBeforeBackground = true
                            appWasInBackground = true      // <--- NEW
                            userDefaults.set(true, forKey: "wasPaused")
                        }
                    }
                    
                    if scenePhase == .active {
                        if appWasInBackground && wasPausedBeforeBackground {
                            showResumeAlert = true
                        }
                        
                        // Reset flags AFTER alert logic
                        wasPausedBeforeBackground = false
                        appWasInBackground = false
                        userDefaults.set(false, forKey: "wasPaused")
                        
                        resetIfNewDay()
                    }
                }
                .onAppear {
                    resetIfNewDay()
                    let wasPaused = userDefaults.bool(forKey: "wasPaused")
                    if wasPaused && !isRunning && elapsedSeconds > 0 {
                        showResumeAlert = true
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
            GoalTimeView(goalTime: $goalTime, isPresented: $isSheetPresented, goalTimeLeft: $goalTimeLeft)
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

#Preview {
    ContentView(goalTime: 0, goalTimeLeft: 5, lastTimerStart: Calendar.current)
}
