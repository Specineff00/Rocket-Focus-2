//
//  UserDefaultsRepository.swift
//  Rocket Focus 2
//
//  Created by Yogesh Nikash Ramsorrun on 21/10/2022.
//

import Foundation

protocol UserDefaultable {
    func saveValue(forKey key: StorageKey, value: Any)
    func readValue<T>(forKey key: StorageKey) -> T?
    func saveDate(forKey key: StorageKey, date: Date)
    func readDate(forKey key: StorageKey) -> Date?
    func removeDate()
}

struct UserDefaultsRepository: UserDefaultable {
    
    let userDefaults: UserDefaults
    
    // MARK: - Lifecycle
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveValue(forKey key: StorageKey, value: Any) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func saveDate(forKey key: StorageKey, date: Date) {
        let isoDateFormatter = ISO8601DateFormatter()
        let isoString = isoDateFormatter.string(from: date)
        userDefaults.set(isoString, forKey: key.rawValue)
    }
    
    func readValue<T>(forKey key: StorageKey) -> T? {
        return userDefaults.value(forKey: key.rawValue) as? T
    }
    
    func readDate(forKey key: StorageKey) -> Date? {
        guard let string = userDefaults.value(forKey: key.rawValue) as? String else {
            return nil
        }
        
        let isoDateFormatter = ISO8601DateFormatter()
        return isoDateFormatter.date(from: string)
    }
    
    func removeDate() {
        userDefaults.removeObject(forKey: StorageKey.lockDate.rawValue)
    }
}


struct MockUserDefaults: UserDefaultable {
    func saveValue(forKey key: StorageKey, value: Any) {
    }
    
    func readValue<T>(forKey key: StorageKey) -> T? {
        return nil
    }
    
    func saveDate(forKey key: StorageKey, date: Date) {
    }
    
    func readDate(forKey key: StorageKey) -> Date? {
        return nil
    }
    
    func removeDate() {
    }
}
