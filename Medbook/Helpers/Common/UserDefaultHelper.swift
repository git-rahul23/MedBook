//
//  UserDefaultHelper.swift
//  Medbook
//
//  Created by RAHUL RANA on 27/12/23.
//

import Foundation

enum UserDefKey: String {
    case loggedIn
    case recentSearches
}

struct UserDefaultHelper {
    
    static func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefKey.loggedIn.rawValue)
    }
    
    static func setLoggedIn(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefKey.loggedIn.rawValue)
    }
    
    static func setRecentSearches(_ value: [String]) {
        UserDefaults.standard.set(value, forKey: UserDefKey.recentSearches.rawValue)
    }
    
    static func getRecentSearches() -> [String]? {
        if let values = UserDefaults.standard.array(forKey: UserDefKey.recentSearches.rawValue) as? [String] {
            return values
        }
        return nil
    }
    
}
