//
//  Rocket_Focus_2App.swift
//  Rocket Focus 2
//
//  Created by Yogesh Nikash Ramsorrun on 20/10/2022.
//

import SwiftUI
import Then

@main
struct Rocket_Focus_2App: App {
    let deviceEventObserver = DeviceEventObserver().then { $0.setupObservers() }
        
    var body: some Scene {
        WindowGroup {
            ContentView(
                timerHandler: TimerHandler(
                    userDefaults: UserRepository()
                )
            )
        }
    }
}
