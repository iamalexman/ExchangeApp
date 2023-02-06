//
//  CurrencyPairsRatesRouter.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 25.07.2022.
//

import Foundation
import UIKit

class CurrencyPairsRatesRouter: CurrencyPairsRatesRouterProtocol {
    
    static func createModule() -> CurrencyPairsRatesViewController {
        
        let view = CurrencyPairsRatesViewController()
        let presenter = CurrencyPairsRatesPresenter()
        let interactor = CurrencyPairsRatesInteractor(presenter: presenter)
        let router = CurrencyPairsRatesRouter()
    
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
    func presentCurrencyPairSelector(from view: CurrencyPairsRatesViewProtocol, delegate: SelectCurrencyPairDelegate) {
        
        let listCurrenciesViewController = CurrencyPairSelectorRouter.createModule(delegate: delegate)
        guard let listCurrencies = view as? UIViewController else {
            fatalError("Invalid view Protocol type")
        }
        listCurrencies.navigationController?.present(listCurrenciesViewController, animated: true)
    }
    
    func presentNewsViewController(from view: CurrencyPairsRatesViewProtocol) {
        
        let newsViewController = NewsRouter.createModule()
        
        guard let listCurrencies = view as? UIViewController else {
            fatalError("Invalid view Protocol type")
        }
        listCurrencies.show(newsViewController, sender: nil)
    }
}
