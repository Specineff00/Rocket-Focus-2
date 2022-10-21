//
//  TimeHandler.swift
//  Rocket Focus 2
//
//  Created by Yogesh Nikash Ramsorrun on 20/10/2022.
//

import Foundation
import Combine

class TimerHandler: ObservableObject {
    @Published var secondsLeft = 0
    private var cancellableTimer: Cancellable?
    private let timerPublusher = Timer.publish(every: 1, on: .main, in: .common)
    var startDate: Date?
    let userDefaults: any UserDefaultable
    
    internal init(userDefaults: any UserDefaultable = UserRepository()) {
        self.userDefaults = userDefaults
    }
    

    // MARK: - Public
    public func startTimer(duration: Int = Constants.pomodoroWorkMinutes.minutesInSeconds) {
        startDate = nil
        secondsLeft = duration
        cancellableTimer = timerPublusher
            .autoconnect()
            .sink(
                receiveValue: { [weak self] date in
                    if self?.startDate == nil {
                        self?.startDate = date
                        print("Date set \(date)")
                    }
                    self?.decrementTime()
                }
            )
    }
    
    func cancelTimer() {
        cancellableTimer = nil
        print("Timer cancelled")
    }
    
    // MARK: - Private
    private func decrementTime() {
        guard secondsLeft > 0 else {
            cancellableTimer = nil
            print("Timer finished")
            return
        }
        secondsLeft -= 1
        print("Seconds left \(secondsLeft)")
    }
    
    //Saves the date so that it can be resumed when coming out of lock with the correct time
    func suspendTimer() {
        cancellableTimer = nil
        userDefaults.removeDate()
        
        guard let date = startDate else { return }
        userDefaults.saveDate(forKey: .lockDate, date: date)
        let retrievedDate = userDefaults.readDate(forKey: .lockDate)
        print("retrieved \(String(describing: retrievedDate))")
    }
    
    func resumeTimer() {
        guard let retrievedDate = userDefaults.readDate(forKey: .lockDate) else {
            return
        }
        let presetDuration = Constants.pomodoroWorkMinutes.minutesInSeconds
        let timePassedInSeconds = Date().timeIntervalSince(retrievedDate)
        let newSecondsLeft = presetDuration - Int(timePassedInSeconds)
        print(newSecondsLeft)
        startTimer(duration: newSecondsLeft)
    }
    
    
}

protocol UserDefaultable {
    func saveValue(forKey key: StorageKey, value: Any)
    func readValue<T>(forKey key: StorageKey) -> T?
    func saveDate(forKey key: StorageKey, date: Date)
    func readDate(forKey key: StorageKey) -> Date?
    func removeDate()
}

enum StorageKey: String, CaseIterable {
    case lockDate
}
