//
//  SessionHelper.swift
//  ThreAdY
//
//  Created by Adrian Yu on 22/08/24.
//

import Foundation

class SessionHelper {
    
    static let shared = SessionHelper()
    
    private init() {}

    private let key = "current_username"
    
    var username: String? {
        get {
            return UserDefaults.standard.string(forKey: key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    func setUsername(username: String){
        self.username = username;
    }
    
    func getUsername() -> String? {
        return username
    }
    
    func clearSession(){
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func isLoggedIn() -> Bool {
        return username != nil
    }
    
}
