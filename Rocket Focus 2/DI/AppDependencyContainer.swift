//
//  AppDependencyContainer.swift
//  Rocket Focus 2
//
//  Created by Yogesh Nikash Ramsorrun on 21/10/2022.
//

import Foundation
import Swinject
import SwinjectAutoregistration

final class AppDependencyContainer {
    
    static let `default` = AppDependencyContainer()
    let container = Container()
    
    private init() {
        setupDefaultContainers()
    }
    
    private func setupDefaultContainers() {
        container.autoregister(UserDefaults.self, initializer: UserDefaults.init)
        container.register(UserDefaults.self) { _ in UserDefaults.standard.self }
        container.register(UserDefaultable.self) { resolver in
            resolver ~> UserDefaultsRepository.self
        }
        container.autoregister(
            UserDefaultsRepository.self,
            initializer: UserDefaultsRepository.init
        )
        container.autoregister(DeviceEventObserver.self, initializer: DeviceEventObserver.init)
        container.autoregister(TimerHandler.self, initializer: TimerHandler.init)
        container.autoregister(TimerViewModel.self, initializer: TimerViewModel.init)
    }
    
    static func resolve<Service>(_ type: Service.Type) -> Service {
        guard let service = AppDependencyContainer.default.container.resolve(type) else {
            preconditionFailure("Could not resolve \(String(describing: type)) into dependency")
        }
        
        return service
    }
}
