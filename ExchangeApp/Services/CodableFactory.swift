//
//  CodableFactory.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 19.07.2022.
//

import Foundation

class CodableFactory: CodableFactoryProtocol {

    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                print(jsonData)
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func parsingDictionary(data: Data) -> [String: String] {
        do {
            let decodeData = try JSONDecoder().decode([String: String].self, from: data)
            return decodeData
        } catch {
            print(error)
        }
        return[:]
    }
    
    func parsingArray(data: Data) -> [String] {
        do {
            let decodeData = try JSONDecoder().decode([String].self, from: data)
            return decodeData
        } catch {
            print(error)
            return []
        }
    }
}
