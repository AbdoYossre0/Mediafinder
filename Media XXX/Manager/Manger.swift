//
//  Manger.swift
//  Media XXX
//
//  Created by abdoyossre on 8/19/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import UIKit

class UserDefultsManger {
    
    let defaults = UserDefaults.standard
    
    private static let sharedInstance = UserDefultsManger()
    
    private init() {}
    
    static func shared() -> UserDefultsManger {
        return UserDefultsManger.sharedInstance
    }
    
    var isLoggedIn: Bool {
        set {
            defaults.set(newValue, forKey: UserDefaultsKey.isLogedIn)
        }
        get {
            guard defaults.object(forKey: UserDefaultsKey.isLogedIn) != nil else {
                return false
            }
            return defaults.bool(forKey: UserDefaultsKey.isLogedIn)
        }
    }
    
    var user: User {
        set {
            setUserDefaults(user: newValue)
        }
        get {
            return getUserDefalts()!
        }
    }
    
    private func setUserDefaults(user:User){
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            defaults.set(encoded, forKey: UserDefaultsKey.user)
        }
    }
    
    private func getUserDefalts() -> User? {
        
        if let savedUser = defaults.object(forKey: UserDefaultsKey.user) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                return loadedUser
            }
        }
        return nil
    }
}
