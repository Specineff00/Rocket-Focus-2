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
    @Published var isTimerStopped = true
    private var cancellableTimer: Cancellable? {
        willSet { isTimerStopped = newValue == nil }
    }
    private let timerPublusher = Timer.publish(every: 1, on: .main, in: .common)
    private var startDate: Date?
    private let userDefaults: any UserDefaultable
    
    internal init(userDefaults: any UserDefaultable = UserDefaultsRepository()) {
        self.userDefaults = userDefaults
    }
    

    // MARK: - Public
    public func startTimer(duration: Int) {
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
    
    //Saves the date so that it can be resumed when coming out of lock with the correct time
    func suspendTimer() {
        cancellableTimer = nil
        userDefaults.removeDate()
        
        guard let date = startDate else { return }
        userDefaults.saveDate(forKey: .lockDate, date: date)
        let retrievedDate = userDefaults.readDate(forKey: .lockDate)
        print("retrieved \(String(describing: retrievedDate))")
    }
    
    func wakeTimer() {
        guard let retrievedDate = userDefaults.readDate(forKey: .lockDate) else {
            return
        }
        let presetDuration = Constants.pomodoroWorkMinutes.minutesInSeconds
        let timePassedInSeconds = Date().timeIntervalSince(retrievedDate)
        let newSecondsLeft = presetDuration - Int(timePassedInSeconds)
        print(newSecondsLeft)
        startTimer(duration: newSecondsLeft)
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
    
}
