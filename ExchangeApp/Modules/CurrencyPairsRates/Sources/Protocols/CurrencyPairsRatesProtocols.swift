//
//  CurrencyPairsRatesViewProtocol.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 26.07.2022.
//

import Foundation

protocol CurrencyPairsRatesViewProtocol: AnyObject {
    
    // PRESENTER -> VIEW
    func showCurrencyPairs(_ pairs: [CurrencyPair])
    func showErrorMessage(_ message: String)
    func reloadTableViewData()
}

protocol CurrencyPairsRatesPresenterProtocol: AnyObject {
    
    var currencyPairs: [CurrencyPair] { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showCurrencyPairSelector()
    func goToNewsViewController()
    func addCurrencyPair(_ pair: CurrencyPair)
    func removeCurrencyPair(_ pair: CurrencyPair)
    func viewDidSrartRefreshing()
}

protocol CurrencyPairsRatesInteractorInputProtocol: AnyObject {
    
    // PRESENTER -> INTERACTOR
    func retrieveCurerncyRates()
    func deleteCurrencyPair(_ pair: CurrencyPair)
    func saveCurrencyPair(_ pair: CurrencyPair)
    func getOutputCurrencyRatio(for: CurrencyPair)
    func startTimerToReloadRates()
    func justShowPairs()
}

protocol CurrencyPairsRatesInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didRetrieveCurrencyPair(_ pairs: [CurrencyPair])
    func didRemoveCurrencyPair(_ pair: CurrencyPair)
    func onError(message: String)
    func reloadTableViewForFetchNewRates()
}

protocol CurrencyPairsRatesRouterProtocol: AnyObject {
    
    static func createModule() -> CurrencyPairsRatesViewController

    // PRESENTER -> ROUTER
    func presentCurrencyPairSelector(from: CurrencyPairsRatesViewProtocol, delegate: SelectCurrencyPairDelegate)
    
    func presentNewsViewController(from: CurrencyPairsRatesViewProtocol)
}

protocol SelectCurrencyPairDelegate: AnyObject {
    
    // DATA DELEGATE
    func onSelectCurrencyData(_ pair: CurrencyPair)
}
