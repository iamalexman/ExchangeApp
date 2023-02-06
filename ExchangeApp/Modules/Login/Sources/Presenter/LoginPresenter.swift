//
//  LoginPresenter.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 23.08.2022.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    func viewDidLoad() -> String {
        if interactor?.checkUserInStorage() == true {
            showCurrencyPairsRatesViewController()
        }
        return interactor?.returnUserName() ?? ""
    }
    
    func exitButtonPressed() {
        interactor?.checkUserInStorage() ?? true ? view?.showAlert("User has been successfully deleted") : view?.showAlert("No user was found")
        interactor?.deleteUserFromStore()
    }
    
    func showCurrencyPairsRatesViewController() {
        guard let view = view else { return }
        router?.presentCurrencyPairsRatesViewController(from: view, delegate: self)
    }
    
    func loginCheck(login: String?, password: String?) -> String {
        if interactor?.simpleCheckLogin(login: login, password: password) == false {
            view?.showAlert("Invalid username or password, repeat the entry, please")
            return ""
        } else {
            showCurrencyPairsRatesViewController()
            return login ?? ""
        }
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func showMessage(message: String) {
        view?.showAlert(message)
    }
}

extension LoginPresenter: LoginDelegateProtocol { }
