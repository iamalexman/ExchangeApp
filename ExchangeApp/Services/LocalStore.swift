//
//  CurencyPairsStore.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 03.08.2022.
//

import Foundation

class LocalStore {
    
//    let defaults = UserDefaults.standard
    
    var dictionary: Dictionary = [String: [String]]()
    public static let shared = LocalStore()
    public private(set) var pairs: [CurrencyPair] = []

    private init() { }
    
    func addNewPair(_ pair: CurrencyPair) {
        pairs.append(pair)
    }
    
    func removePair(_ pair: CurrencyPair) {
        if let index = pairs.firstIndex(where: { $0 === pair }) {
            pairs.remove(at: index)
        }
    }
    
    func isKeyAvailable(key: String) -> Bool {
        dictionary.keys.contains(key)
    }
    
    func checkCopyForKey(pair: [CurrencyTableViewCellModel]) -> Bool {
        
        guard let first = pair.first?.shortTitleLabel, let last = pair.last?.shortTitleLabel else { return false }
        
        if !isKeyAvailable(key: first) {
            dictionary[first] = [last]
        } else {
            for value in dictionary[first] ?? [] {
                if value == last {
                    return false
                }
            }
            dictionary[first]?.append(last)
        }
        print(dictionary)
        return true
    }
    
    func deleteValueForKey(pair: CurrencyPair) {
        
        let first = pair.first.shortTitle
        let second = pair.second.shortTitle
        
        dictionary[first]?.forEach { value in
            dictionary[first] = dictionary[first]?.filter{ $0 != second }
        }
        if dictionary[first]?.count == .zero {
            dictionary[first] = nil
        }
    }
}
