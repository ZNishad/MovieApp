//
//  UDefaults.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 05.03.25.
//

import Foundation

struct UserDefaultsHelper {
    static let defaults = UserDefaults.standard

    static func setString(_ string: String, key: String) {
        defaults.set(string, forKey: key)
        defaults.synchronize()
    }

    static func setInt(_ int: Int, key: String) {
        defaults.set(int, forKey: key)
        defaults.synchronize()
    }

    static func getString(key: String) -> String? {
        defaults.string(forKey: key)
    }

    static func getInt(key: String) -> Int? {
        defaults.integer(forKey: key)
    }

    static func removeString(key: String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}
