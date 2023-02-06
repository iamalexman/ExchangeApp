//
//  NetworkService.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 18.08.2022.
//

import Foundation

struct CurrenciesService: APIService, CurrencyServiceProtocol {
    
    func getRates(inputCode: String, outputCode: String) async -> Result<APIModel, APIError> {
        return await load(url: CurrencyURLComponents.getRates(first: inputCode, second: outputCode), responseModel: APIModel.self)
    }
}
