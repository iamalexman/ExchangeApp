//
//  NewsService.swift
//  ExchangeApp
//
//  Created by Alex Smith on 24.08.2022.
//

import Foundation

struct NewsService: APIService, NewsServiceProtocol {
    
    func getNews(inputCode: String, outputCode: String) async -> Result<APIModel, APIError> {
        return await load(url: CurrencyURLComponents.getRates(first: inputCode, second: outputCode), responseModel: APIModel.self)
    }
}
