//
//  UserDefaultsHelper.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/26.
//

import Foundation

class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    private init() { }
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case isLaunched
    }
    
    var isLaunched: Bool {
        get {
            return userDefaults.bool(forKey: Key.isLaunched.rawValue)
        }
        set {
            return userDefaults.set(newValue, forKey: Key.isLaunched.rawValue)
        }
    }
    
}
