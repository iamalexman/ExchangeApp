//
//  CurrencyPairSelectorRouter.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 26.07.2022.
//

import Foundation
import UIKit

class CurrencyPairSelectorRouter: CurrencyPairSelectorRouterProtocol {
    
    static func createModule(delegate: SelectCurrencyPairDelegate) -> CurrencyPairSelectorViewController {
        
        let view = CurrencyPairSelectorViewController()
        let presenter = CurrencyPairSelectorPresenter()
        let interactor = CurrencyPairSelectorInteractor(presenter: presenter)
        let router = CurrencyPairSelectorRouter()

        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.delegate = delegate
        
        interactor.presenter = presenter
        
        return view
    }

    func navigateBackToMainScreen(from view: CurrencyPairSelectorViewProtocol) {
        guard let listCurrencies = view as? UIViewController else {
            fatalError("Invalid view Protocol type")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Time delay to dismiss View after selected second item
            listCurrencies.dismiss(animated: true, completion: nil)
            _ = listCurrencies.navigationController?.popToRootViewController(animated: true)
        }
    }
}
