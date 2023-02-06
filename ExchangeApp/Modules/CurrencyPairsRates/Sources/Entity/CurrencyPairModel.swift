//
//  CurrencyModel.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 19.07.2022.
//

import Foundation

class CurrencyPair: Codable {
    
    let first: CurrencyEntity
    let second: CurrencyEntity
    var rate: Double?
    var isNewPair: Bool
    
    init(first: CurrencyEntity, second: CurrencyEntity, rate: Double, isNewPair: Bool) {
        self.first = first
        self.second = second
        self.rate = rate
        self.isNewPair = isNewPair
    }
}
