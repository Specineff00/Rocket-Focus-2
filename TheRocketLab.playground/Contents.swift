import UIKit
import Combine
//import Rocket_Focus_2



let ttt = TimerHandler()
ttt.startTimer()

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    ttt.cancelTimer()
}
