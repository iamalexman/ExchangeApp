//
//  RequestModel.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 19.08.2022.
//

import Foundation

import Foundation

struct APIModel: Codable {
    let base: String?
    let rates: [String: Double]
    
    init() {
        base = ""
        rates = ["": 0]
    }
}
