//
//  CurrencyPairsRatesPresenter.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 25.07.2022.
//

import Foundation

class CurrencyPairsRatesPresenter: CurrencyPairsRatesPresenterProtocol {
    
    weak var view: CurrencyPairsRatesViewProtocol?
    var interactor: CurrencyPairsRatesInteractorInputProtocol?
    var router: CurrencyPairsRatesRouterProtocol?
    
    var currencyPairs: [CurrencyPair] = []
    
    func viewDidLoad() {
        interactor?.justShowPairs()
        interactor?.startTimerToReloadRates()
    }
    
    func showCurrencyPairSelector() {
        guard let view = view else { return }
        router?.presentCurrencyPairSelector(from: view, delegate: self)
    }
    
    func goToNewsViewController() {
        guard let view = view else { return }
        router?.presentNewsViewController(from: view)
    }
    
    func addCurrencyPair(_ pair: CurrencyPair) {
        interactor?.saveCurrencyPair(pair)
    }
    
    func removeCurrencyPair(_ pair: CurrencyPair) {
        interactor?.deleteCurrencyPair(pair)
    }
    
    func viewDidSrartRefreshing() {
        interactor?.retrieveCurerncyRates()
    }
}

extension CurrencyPairsRatesPresenter: CurrencyPairsRatesInteractorOutputProtocol {
    
    // MARK: - Interactor Output Protocol
    
    func didRemoveCurrencyPair(_ pair: CurrencyPair) {
        interactor?.retrieveCurerncyRates()
    }

    func didRetrieveCurrencyPair(_ pairs: [CurrencyPair]) {
        view?.showCurrencyPairs(pairs)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
    
    func reloadTableViewForFetchNewRates() {
        view?.reloadTableViewData()
    }
}

extension CurrencyPairsRatesPresenter: SelectCurrencyPairDelegate {

    // MARK: - Delegate
    
    func onSelectCurrencyData(_ pair: CurrencyPair) {
        interactor?.saveCurrencyPair(pair)
        interactor?.retrieveCurerncyRates()
    }
}
