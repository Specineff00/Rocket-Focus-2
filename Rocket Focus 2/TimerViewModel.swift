//
//  TimerViewModel.swift
//  Rocket Focus 2
//
//  Created by Yogesh Nikash Ramsorrun on 21/10/2022.
//

import Foundation
import Combine
import SwiftUI

class TimerViewModel: ObservableObject {
    @ObservedObject private var timeHandler: TimerHandler
    @ObservedObject private var deviceEventObserver: DeviceEventObserver
    @Published var timerText: String = ""
    
    private var isUnlockedCancellable: Cancellable?
    
    init(
        timeHandler: TimerHandler,
        deviceEventObserver: DeviceEventObserver
    ) {
        self.timeHandler = timeHandler
        self.deviceEventObserver = deviceEventObserver
    }
    
    func bind() {
        timeHandler.$secondsLeft
            .map { seconds in
                let (_, minutesLeft, secondsLeft) = TimeInterval(seconds).toHoursMinutesSeconds()
                return "\(minutesLeft):\(secondsLeft)"
            }
            .assign(to: &$timerText)
        
        isUnlockedCancellable = deviceEventObserver
            .$isDeviceLocked
            .sink(receiveCompletion: { value in
                print(value)
            }, receiveValue: { value in
                print(value)
            })
//            .sink { [weak timeHandler] isLocked in
//                isLocked ? timeHandler?.suspendTimer() : timeHandler?.wakeTimer()
//            }
        
        let locky = deviceEventObserver.isLockedSubject.sink { completion in
            print(completion)
        } receiveValue: { message in
            print("Received message: \(message)")
        }
    }
    
    func startTimer(minutes: Int = Constants.pomodoroWorkMinutes) {
        timeHandler.startTimer(duration: minutes)
    }
    
    func cancelTimer() {
        timeHandler.cancelTimer()
    }
    
}
