//
//  LoginRouter.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 23.08.2022.
//

import Foundation
import UIKit

class LoginRouter: LoginRouterProtocol {
   
    static func createModule() -> LoginViewController {
        
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter)
        let router = LoginRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
    func presentCurrencyPairsRatesViewController(from view: LoginViewProtocol, delegate: LoginDelegateProtocol) {
        
        let pairsViewController = CurrencyPairsRatesRouter.createModule()
        
        guard let loginView = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        loginView.show(pairsViewController, sender: nil)
    }
}

