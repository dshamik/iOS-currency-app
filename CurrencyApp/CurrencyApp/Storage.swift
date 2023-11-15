//
//  Storage.swift
//  CurrencyApp
//
//  Created by Динар Шамсутдинов on 15.11.2023.
//

import Foundation

class Storage {
    let key = "currency-app"
    
    func save(currency: String) {
        UserDefaults.standard.setValue(currency, forKey: key)
    }
    
    func load() -> String? {
        UserDefaults.standard.string(forKey: key)
    }
}
