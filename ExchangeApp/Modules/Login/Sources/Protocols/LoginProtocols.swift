//
//  LoginProtocols.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 23.08.2022.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    
    // PRESENTER -> VIEW
    func showAlert(_ message: String)
}

protocol LoginPresenterProtocol: AnyObject {
    
    // VIEW -> PRESENTER
    func viewDidLoad() -> String
    func showCurrencyPairsRatesViewController()
    func loginCheck(login: String?, password: String?) -> String
    func exitButtonPressed()
}

protocol LoginInteractorInputProtocol: AnyObject {
    
    // PRESENTER -> INTERACTOR
    func returnUserName() -> String
    func deleteUserFromStore()
    func simpleCheckLogin(login: String?, password: String?) -> Bool
    func checkUserInStorage() -> Bool
}

protocol LoginInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func showMessage(message: String)
}

protocol LoginRouterProtocol: AnyObject {
    
    static func createModule() -> LoginViewController
    
    // PRESENTER -> ROUTER
    func presentCurrencyPairsRatesViewController(from: LoginViewProtocol, delegate: LoginDelegateProtocol)
}

protocol LoginDelegateProtocol: AnyObject { }
