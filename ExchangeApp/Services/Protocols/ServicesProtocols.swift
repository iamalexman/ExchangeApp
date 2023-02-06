//
//  ServicesProtocols.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 26.07.2022.
//

import Foundation

protocol CodableFactoryProtocol {
    
    func readLocalFile(forName name: String) -> Data?
    func parsingDictionary(data: Data) -> [String: String]
    func parsingArray(data: Data) -> [String]
}

protocol CurrencyServiceProtocol {
    func getRates(inputCode: String, outputCode: String) async -> Result<APIModel, APIError>
}

protocol NewsServiceProtocol {
    func getNews(inputCode: String, outputCode: String) async -> Result<APIModel, APIError>
}
