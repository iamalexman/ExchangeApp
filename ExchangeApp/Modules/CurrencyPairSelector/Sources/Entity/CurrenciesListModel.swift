//
//  CurrencyEntity.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 26.07.2022.
//

import Foundation

public class CurrencyEntity: Codable {
    public var title: String
    public var shortTitle: String
    
    public init(title: String, shortTitle: String) {
        self.title = title
        self.shortTitle = shortTitle
    }
}
