//
//  StreakTestView.swift
//  swift-challenge-3
//
//  Created by Sophie Lian on 14/11/25.
//

import SwiftUI

extension Date {
    
    // for tomorow's Date
    static var tomorrow:  Date { return Date().dayAfter }
    static var today: Date {return Date()}
    var dayAfter: Date {
       return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        // just add .minute after byAdding: , to create a streak minute counter and check the logic.
    }

    static func getTodayDate() -> String {

           let dateFormatter = DateFormatter()

           dateFormatter.dateFormat = "E d MMM yyyy"
        //to continue with the minute streak builder just add "E d MMM yyyy h:mm a" above, it will allow date formatting with minutes and follow the changes in dayAfter

        return dateFormatter.string(from: Date.today)

       }
    
    static func getTomDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E d MMM yyyy"
        
        return dateFormatter.string(from: Date.tomorrow)
    }
}

struct StreakApp: View {
    
    @State @AppStorage("counter") var counter = 0
    @AppStorage("tapDate") var TapDate: String?
    @AppStorage("Tappable") var ButtonTapped = false
    var body: some View {
        NavigationView {
            VStack{
                VStack {
                    Text("\(counter)").foregroundColor(.gray)
                    Text("Restore your streak tomorrow on ")
                    Text(TapDate ?? "No Date")
                    Image(systemName: "flame")
                        .resizable()
                        .frame(width: 40, height: 50)
                        .padding()
                        .scaledToFit()
                        .background(ButtonTapped ? Color.red : Color.gray)
                        .foregroundColor(ButtonTapped ? Color.orange : Color.black)
                        .cornerRadius(12)
                }
                Button {
                    if  TapDate == nil {
                        //Check if user has already tapped
                        self.ButtonTapped = true
                        counter += 1
                        self.TapDate = ("\(Date.getTomDate())")
                    }
                    else if ("\(Date.getTodayDate())") == TapDate {
                        //Check for the consecutive Day of Streak
                       
                        self.TapDate = ("\(Date.getTomDate())")
                        counter += 1
                        //Let's light the flame back again.
                        self.ButtonTapped = true
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .foregroundColor(.black)
                        .frame(width: 120, height: 40)
                        .overlay {
                            Text("Add Streak")
                                .foregroundColor(.white)
                        }
                }
                .padding()
                //This button is only for testing purpose.
                Button {
                    self.TapDate = nil
                    self.ButtonTapped = false
                    self.counter = 0
                } label: {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .foregroundColor(.black)
                        .frame(width: 160, height: 40)
                        .overlay {
                            Text("Reset Streak")
                                .foregroundColor(.white)
                        }
                }
          
            }
            //Ensuer the flame dies out if we run into any other day except today or tommorow.
            .onAppear {
                if ("\(Date.getTodayDate())") == TapDate ||
                    ("\(Date.getTomDate())") == TapDate {
                    self.ButtonTapped = true
                }
                //Breaking the Streak
                else {
                    self.TapDate = nil
                    self.ButtonTapped = false
                    self.counter = 0
                }
          
            }
        }
    }
}

struct StreakApp_Previews: PreviewProvider {
    static var previews: some View {
        StreakApp()
    }
}
