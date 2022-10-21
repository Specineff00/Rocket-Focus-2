//
//  DeviceEventObserver.swift
//  Rocket Focus 2
//
//  Created by Yogesh Nikash Ramsorrun on 21/10/2022.
//

import Foundation
import Combine
import SwiftUI

class DeviceEventObserver: NSObject, ObservableObject {
    @Published var isDeviceLocked = false
    @Published var isAppActive = true
    
    private var notificationCancellable: Cancellable?
    private var unlockCancellable: Cancellable?
    private var lockCancellable: Cancellable?
    private var resignsActiveCancellable: Cancellable?
    private var becomeActiveCancellable: Cancellable?
    
    func setupObservers() {
        addDeviceLockedObserver()
        addDeviceUnlockedObserver()
        addDeviceResignedActiveObserver()
        addDeviceBecomeActionObserver()
    }
    
    func clearObservers() {
        notificationCancellable = nil
        unlockCancellable = nil
        lockCancellable = nil
        resignsActiveCancellable = nil
        becomeActiveCancellable = nil
    }
    
    private func addDeviceUnlockedObserver() {
        unlockCancellable = nil
        unlockCancellable = NotificationCenter.default
            .publisher(for:  UIApplication.protectedDataDidBecomeAvailableNotification)
            .sink() { [weak self] _ in self?.isDeviceLocked = false }
    }
    
    private func addDeviceLockedObserver() {
        lockCancellable = nil
        lockCancellable = NotificationCenter.default
            .publisher(for:  UIApplication.protectedDataWillBecomeUnavailableNotification)
            .sink() { [weak self] _ in self?.isDeviceLocked = true }
    }
    
    private func addDeviceResignedActiveObserver() {
        resignsActiveCancellable = nil
        resignsActiveCancellable = NotificationCenter.default
            .publisher(for:  UIApplication.willResignActiveNotification)
            .sink() { [weak self] _ in self?.isAppActive = false }
    }
    
    private func addDeviceBecomeActionObserver() {
        becomeActiveCancellable = nil
        becomeActiveCancellable = NotificationCenter.default
            .publisher(for:  UIApplication.didBecomeActiveNotification)
            .sink() { [weak self] _ in self?.isAppActive = true}
    }
}

