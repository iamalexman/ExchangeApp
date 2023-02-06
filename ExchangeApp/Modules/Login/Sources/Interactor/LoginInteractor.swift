//
//  LoginInteractor.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 23.08.2022.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
    
    var presenter: LoginInteractorOutputProtocol?
    
    private var userData: [String: String] = [:]
    private let userDefaults = UserDefaults.standard
    
    required init(presenter: LoginInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func checkUserInStorage() -> Bool {
        userDefaults.bool(forKey: "new")
    }
    
    func returnUserName() -> String {
        
        var result = ""
        
        userDefaults.dictionary(forKey: "user")?.keys.forEach { key in
            result = key
            userDefaults.dictionary(forKey: "user")?.values.forEach { value in
                userData[key] = value as? String
            }
        }
        return result
    }
    
    func deleteUserFromStore() {
        userDefaults.removeObject(forKey: "user")
        userDefaults.set(false, forKey: "new")
    }
    
    func simpleCheckLogin(login: String?, password: String?) -> Bool {
        if let name = login, let pass = password {
            if name.count < 3 || pass.count < 3 {
                return false
            } else {
                userData[name] = pass
                userDefaults.set(userData, forKey: "user")
                userDefaults.set(true, forKey: "new")
            }
        }
        return true
    }
}
