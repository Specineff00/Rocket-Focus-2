import UIKit
import Combine
//import Rocket_Focus_2



let timerHandler = TimerHandler()
timerHandler.startTimer()

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//    timerHandler.cancelTimer()
    timerHandler.suspendTimer()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
//    timerHandler.cancelTimer()
    timerHandler.resumeTimer()
}

