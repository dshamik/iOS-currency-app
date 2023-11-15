//
//  ScreenState.swift
//  CurrencyApp
//
//  Created by Динар Шамсутдинов on 15.11.2023.
//

import Foundation

enum ScreenState {
    case error(description: String)
    case loading
    case data(data: ExchangeData)
}
