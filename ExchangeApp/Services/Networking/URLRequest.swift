//
//  EndpointExchangeRates.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 18.08.2022.
//

import Foundation

protocol URLBuilder {
    
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var query: [URLQueryItem]? { get }
}

extension URLBuilder {
    
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.apilayer.com"
    }
}

enum CurrencyURLComponents {
    case getRates(first: String, second: String)
}

extension CurrencyURLComponents: URLBuilder {
    
    var method: RequestMethod {
        switch self {
        case .getRates:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getRates:
            return "/fixer/latest"
        }
    }

    var header: [String: String]? {
        switch self {
        case .getRates:
            return ["apikey" : "KNYfvaHC6GIkyL6xDt9oCUiYYZnLLZmy"]
//            return [ds3dmw4JtZe1ZUeLNhreqeZz1kd5o8PL] // for news
//            return ["apikey" : "2Xau0gEffnFFYio8f4Vz8bwKDnYKZ2bd"]
        }
    }
        
    var query: [URLQueryItem]? {
        switch self {
        case .getRates(first: let inputCode, second: let outputCode):
            return [URLQueryItem(name: "symbols", value: outputCode), URLQueryItem(name: "base", value: inputCode)]
        }
    }
}

// news:
//"https://api.apilayer.com/financelayer/news?tickers={tickers}&tags={tags}&sources={sources}&sort={sort}&offset={offset}&limit={limit}&keywords={keywords}&fallback={fallback}&date={date}"

//"https://api.apilayer.com/financelayer/news?tickers={tickers}&tags={tags}&sources={sources}&sort={sort}&offset=0&limit=10&keywords={keywords}&fallback={fallback}&date={date}"


//https://newsapi.org/v2/top-headlines
//mankofeman@gmail.com
//apiKey = "e4745f85f9f241bb8cd722f90ca7370a"
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e4745f85f9f241bb8cd722f90ca7370a
