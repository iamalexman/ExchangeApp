//
//  ParseService.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 26.07.2022.
//

import Foundation

class ParseService {
    
    static public let fetched = ParseService()
    
    init() { }
    
    func getCurrencyEntitys(name: String,
                            suffix: String,
                            comletion: @escaping (Result<[CurrencyEntity], Error>) -> Void) {

        var array = [String]()
        var dictionary = [String: String]()
        var entityArray = [CurrencyEntity]()
        var news = NewsResponse()
        
        if let localData = CodableFactory().readLocalFile(forName: name) {
            array = CodableFactory().parsingArray(data: localData)
        } else {
            comletion(.failure(APIError.decode))
        }
        if let localData = CodableFactory().readLocalFile(forName: name + suffix) {
            dictionary = CodableFactory().parsingDictionary(data: localData)
        } else {
            comletion(.failure(APIError.decode))
        }
        if let localData = CodableFactory().readLocalFile(forName: newsJSON) {
            news = try! JSONDecoder().decode(NewsResponse.self, from: localData)
        } else {
            comletion(.failure(APIError.decode))
        }
        for (key, value) in dictionary {
            if array.contains(key) {
                let newItem = CurrencyEntity(title: value, shortTitle: key)
                entityArray.append(newItem)
            }
        }
        entityArray = entityArray.sorted(by: { $0.title < $1.shortTitle })
        comletion(.success(entityArray))
    }
}
