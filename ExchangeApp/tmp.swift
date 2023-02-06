//
//  DataManager.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 28.07.2022.
//


let dispatchToMain = dispatchToMain
        let task = session.dataTask(with: request) { data, response, error in
            
            RequestHandler.handle(data: data,
                                  response: response,
                                  error: error,
                                  request: request,
                                  dispatchToMain: dispatchToMain,
                                  completion: completion)
            
        }
        
        task.resume()
        return task
    }

билдер

    private func build(_ parameters: [String: Any?]) -> String {
        
        var paramsArray = [String]()
        for key in parameters.keys.sorted(by: <) {
            
            switch parameters[key] {
            case let boolValue as Bool:
                paramsArray.append("\(key)=\(boolValue)")
            case let numberValue as NSNumber:
                paramsArray.append("\(key)=\(numberValue)")
            case let stringValue as String:
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .requestURLParamsAllowed) ?? stringValue
                paramsArray.append("\(key)=\(escapedValue)")
            default:
                assertionFailure("Надо добавить обработчик типа")
            }
        }
        
        return paramsArray.joined(separator: "&")
    }
}

пример вызова

func sendSmsCode(phone: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        RestRequest()
            .setHttpMethod(.post)
            .setApiMethod("v1/user/get/sms_code")
            .setBody(["phone_num": phone])
            .execute { (result: Result<UserResponseApi, Error>) in
                
                switch result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

************************************************************************************

func getOutputCurrencyRatio(newCurrencyPair pair: CurrencyPair?) {
 let requestInputCode = inputItemCode
 let requestOutputCode = outputItemCode
 
 APIService2.getRatio(url: fullURL, inputCode: requestInputCode, outputCode: requestOutputCode, completion: { [weak self] result in

     DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in // need delay because CurrencySelectiorView dismissing animation duration is 0.3sec
         guard let self = self else { return }
         switch result {
         case .success(let result):
             self.currencyPairs[self.currencyPairs.count - 1].rate = result.rates[self.outputItemCode]
             self.presenter?.reloadTableViewForFetchNewRates()
         case .failure(let error):
             self.currencyPairs[self.currencyPairs.count - 1].rate = 1.1
//                    self.presenter?.onError(message: error.localizedDescription)
         }
     }
 })
    
************************************************************************************

import Foundation
import UIKit

struct CurrencyPairRate: Codable {
    let base: String?
    let rates: [String: Double]
    
    init() {
        base = ""
        rates = ["": 0]
    }
}

enum ApiError: Error {
    case URLError(description: String)
    case networkError(statusCode: Int)   //(текст ошибки)
    case decodingError(description: String)
    case managedError(String)
}

class ConverterAPIDataManager: NetworkService {
    
    init() { }
    
    func URLGetRatio(url: String, inputCode: String, outputCode: String) -> String {
        
        var mutateURL = url.replacingOccurrences(of: "{symbols}", with: inputCode)
        
        mutateURL = mutateURL.replacingOccurrences(of: "{base}", with: outputCode)
//        print(mutateURL)
        return mutateURL
    }
    
    func getRatio<T: Codable>(url: String,
                              inputCode: String,
                              outputCode: String,
                              completion: @escaping (Result<T, RequestError>) -> Void) {
        
        let URLString = URLGetRatio(url: url, inputCode: inputCode, outputCode: outputCode)
        
        guard let url = URL(string: URLString) else { return }
        
        load(endpoint: CurrencyEndpoint.getRates, completion: completion)
    }

    func load<T: Codable>(endpoint: Endpoint,
                          completion: @escaping (Result<T, RequestError>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.query
        
        guard let url = urlComponents.url else {
            return completion(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.noResponse))
            }
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                    print(decodedData)
                } catch {
                    completion(.failure(.decode))
                }
                print(String(data: data, encoding: .utf8)!)
            } else {
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
