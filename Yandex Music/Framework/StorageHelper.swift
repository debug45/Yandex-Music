//
//  StorageHelper.swift
//  Yandex Music
//
//  Created by Sergey Moskvin on 13.02.2022.
//

import Foundation

final class StorageHelper {
    
    private static let userDefaults = UserDefaults()
    
    // MARK: Life Cycle
    
    private init() { }
    
    // MARK: Properties
    
    private static let _isFirstLaunch = "isFirstLaunch"
    
    static var isFirstLaunch: Bool? {
        get {
            guard let binaryValue = getFromUserDefaults(forKey: _isFirstLaunch) else {
                return nil
            }
            
            return .init(binaryValue: binaryValue)
        } set {
            setToUserDefaults(newValue?.binaryValue, forKey: _isFirstLaunch)
        }
    }
    
    // MARK: Functions
    
    private static func getFromUserDefaults(forKey key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    private static func setToUserDefaults(_ value: String?, forKey key: String) {
        if let value {
            userDefaults.set(value, forKey: key)
        } else {
            userDefaults.removeObject(forKey: key)
        }
    }
    
}
