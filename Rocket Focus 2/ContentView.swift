//
//  ContentView.swift
//  Rocket Focus 2
//
//  Created by Yogesh Nikash Ramsorrun on 20/10/2022.
//

/*
 This app's will help the user maintain his focus for the time when studying using pomodoroing
 
 This app should:
 - Start a count down of 25 minutes
 - Alert the user when the 25 minutes is up
 - Be able to tell when it has completed a 25 minute session and subsequently start the 5 min timer once the user
 has stopped the alert
 - Be able to alert the user at the end of the 5 minutes
 - Be able to pause the 5 and 25 minute timer at any time.
 - Increment the amount of times the user has completed a cycle of 25 mins
 - Be able to tell when it's the 4th pomodoro and show 15min break
 
 Exploration - Before app making. NO TCA or arch
 - Can a timer exist when locked. ✅
 - Can the app detect when home is pressed or dismissed. ✅
 - Can the app detect when locked. ✅
 - Can detect when dismissed and then locked 🤔
 
 */



import SwiftUI


struct ContentView: View {
    @ObservedObject var timerHandler: TimerHandler
    let deviceLockHandler = DeviceEventObserver()
    @State var timerText = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(String(timerHandler.secondsLeft))
            Button("Start") {
                timerHandler.startTimer()
            }.padding()
            Button("Stop") {
                timerHandler.cancelTimer()
            }.padding()
        }
        .padding()
        .onAppear {

        }
    }    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            timerHandler: TimerHandler(userDefaults: MockUserDefaults())
        )
    }
}

struct MockUserDefaults: UserDefaultable {
    func saveValue(forKey key: StorageKey, value: Any) {
    }
    
    func readValue<T>(forKey key: StorageKey) -> T? {
        return nil
    }
    
    func saveDate(forKey key: StorageKey, date: Date) {
    }
    
    func readDate(forKey key: StorageKey) -> Date? {
        return nil
    }
    
    func removeDate() {
    }
}
