//
//  Api.swift
//  CurrencyApp
//
//  Created by Динар Шамсутдинов on 15.11.2023.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ExchangeData {
    let date: String
    let exchange: [CurrencyData]
}

struct CurrencyData {
    let name: String
    let coefficient: Double
}

class Api {
    func path(currency: String) -> String {
        "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/\(currency).json"
    }
    
    func getData(currency: String) {
        AF.request(path(currency: currency)).response(completionHandler: { result in
            switch result.result {
            case let .success(rawData):
                let json = JSON(rawData)
                let date = json["date"].string
                let exchange = json[currency].dictionary?.map { (k, v) in
                    CurrencyData(name: k, coefficient: v.doubleValue)
                }
                if date != nil && exchange != nil {
                    print(ExchangeData(date: date!, exchange: exchange!))
                } else {
                    print("Couldn't parse :(((")
                }
                
            case let .failure(error):
                print(error.errorDescription)
            }
        })
    }
}
