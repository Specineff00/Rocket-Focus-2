import UIKit
import Combine
//import Rocket_Focus_2



//let timerHandler = TimerHandler()
//timerHandler.startTimer()
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
////    timerHandler.cancelTimer()
//    timerHandler.suspendTimer()
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
////    timerHandler.cancelTimer()
//    timerHandler.resumeTimer()
//}

struct ChatRoom {
    enum Error: Swift.Error {
        case missingConnection
    }
    let subject = PassthroughSubject<String, Error>()
    
    func simulateMessage() {
        subject.send("Hello!")
    }
    
    func simulateNetworkError() {
        subject.send(completion: .failure(.missingConnection))
    }
    
    func closeRoom() {
        subject.send("Chat room closed")
        subject.send(completion: .finished)
    }
}

let chatRoom = ChatRoom()
chatRoom.subject.sink { completion in
    switch completion {
    case .finished:
        print("Received finished")
    case .failure(let error):
        print("Received error: \(error)")
    }
} receiveValue: { message in
    print("Received message: \(message)")
}
chatRoom.simulateMessage()
chatRoom.closeRoom()

let dvo = DeviceEventObserver()

let locky = dvo.isLockedSubject.sink { completion in
    print(completion)
} receiveValue: { message in
    print("Received message: \(message)")
}


