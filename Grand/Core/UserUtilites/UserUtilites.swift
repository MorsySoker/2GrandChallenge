//
//  UserUtilites.swift
//  Grand
//
//  Created by MorsyElsokary on 24/07/2022.
//

import Foundation

protocol UserUtilitesProtocol {
    
    static func saveLang(lang: String)
    static func loadLang() -> String?
    static func deleteLang()
}

class UserUtilites: UserUtilitesProtocol {
    
    struct Keys {
        
        static let lang = "lang"
    }

    static func saveLang(lang: String) {
        UserDefaults.standard.set(lang, forKey: Keys.lang)
        UserDefaults.standard.synchronize()
    }

    static func loadLang() -> String? {
        return UserDefaults.standard.string(forKey: Keys.lang)
    }

    static func deleteLang() {
        UserDefaults.standard.removeObject(forKey: Keys.lang)
    }
}
