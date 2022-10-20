//
//  TimeHandler.swift
//  Rocket Focus 2
//
//  Created by Yogesh Nikash Ramsorrun on 20/10/2022.
//

import Foundation
import Combine

/* This is to handle any session time in minutes
 This should:
 - Start a timer with any time
 - Count down to the end of duration set and finish
 - Can be setup again
 - Seconds left can be observed
 */

class TimerHandler: ObservableObject {
    @Published var secondsLeft = 0
    private var cancellableTimer: Cancellable?
    private let timerPublusher = Timer.publish(every: 1, on: .main, in: .common)
    var startDate: Date?

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
}

extension Optional {
    var isNotNil: Bool { self != nil }
}
