//
//  CurrencyPairSelectorViewProtocol.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 26.07.2022.
//

import Foundation
import UIKit

protocol CurrencyPairSelectorViewProtocol: AnyObject {
    
    // PRESENTER -> VIEW
    func showList(_ currencies: [CurrencyTableViewCellModel])
    func showError(_ message: String)
    func reloadTableViewData()
}

protocol CurrencyPairSelectorPresenterProtocol: AnyObject {
    
    var delegate: SelectCurrencyPairDelegate? { get set }
    var localCurrencyList: [CurrencyTableViewCellModel] { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func toggleSelectModel(indexPath: IndexPath)
    func updateCell(indexPath: IndexPath)
    func viewWillAppear()
    func showCurrencyPairsRates()
    func getCurrencies() -> [CurrencyEntity]
}

protocol CurrencyPairSelectorInteractorInputProtocol: AnyObject {
    
    // PRESENTER -> INTERACTOR
    func resetSelectedTags(currencyModelsList: [CurrencyTableViewCellModel])
    func markSelectedTags(indexPath: IndexPath, currencyModelsList: [CurrencyTableViewCellModel])
    func makeNewPair(newPair: CurrencyTableViewCellModel)
    func makeEntityFromModel(model: CurrencyTableViewCellModel) -> CurrencyEntity
    func addNewCurrencyToMakePair(newEntity: CurrencyEntity)
    func retrieveCurerncyListFromParseService()
    func addPairToStorage(pair: [CurrencyEntity])
    func checkKeyForAvailabilyty(key: String) -> Bool
    func getSelectedCurrencies() -> [CurrencyEntity]
}

protocol CurrencyPairSelectorInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didRetrieveCurrency(_ currencies: [CurrencyTableViewCellModel])
    func closeCurrencyListSelector()
    func success(currencies: [CurrencyTableViewCellModel])
    func failure(errorMessage: String)
}

protocol CurrencyPairSelectorRouterProtocol: AnyObject {
    
    static func createModule(delegate: SelectCurrencyPairDelegate) -> CurrencyPairSelectorViewController

    // PRESENTER -> ROUTER
    func navigateBackToMainScreen(from view: CurrencyPairSelectorViewProtocol)
}
