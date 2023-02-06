//
//  CurrencyPairsRatesInteractor.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 25.07.2022.
//

import Foundation

class CurrencyPairsRatesInteractor: CurrencyPairsRatesInteractorInputProtocol {

    var presenter: CurrencyPairsRatesInteractorOutputProtocol?
    
    // MARK: - Sevices
    
    var APIService: CurrencyServiceProtocol
    var storeService = LocalStore.shared
    var timerToReloadRates: Timer?
    
    var currencyPairs: [CurrencyPair] {
        storeService.pairs
    }

    required init(presenter: CurrencyPairsRatesInteractorOutputProtocol) {
        self.presenter = presenter
        APIService = CurrenciesService()
     }
    
    // MARK: - Reload rates timer
    
    @objc func reloadRatesFromTimer() {
        for index in 0..<currencyPairs.count {
            currencyPairs[index].isNewPair = !currencyPairs[index].isNewPair
        }
        retrieveCurerncyRates()
    }
    
    func startTimerToReloadRates() {
        if timerToReloadRates == nil {
            timerToReloadRates = Timer.scheduledTimer(timeInterval: timeToReloadRates,
                                                      target: self,
                                                      selector: #selector(reloadRatesFromTimer),
                                                      userInfo: nil,
                                                      repeats: true)
        }
    }
    
    // MARK: - Store currencies
    
    func saveCurrencyPair(_ pair: CurrencyPair) {
        storeService.addNewPair(pair)
    }

    func deleteCurrencyPair(_ pair: CurrencyPair) {
        storeService.removePair(pair)
        storeService.deleteValueForKey(pair: pair)
        presenter?.didRemoveCurrencyPair(pair)
    }
    
    // MARK: - Get Rates from APIService
    
    func justShowPairs() {
        presenter?.didRetrieveCurrencyPair(currencyPairs)
    }
    
    func retrieveCurerncyRates() {
        for index in 0..<currencyPairs.count {
            currencyPairs[index].rate! += 0.1
            if currencyPairs[index].isNewPair {
//                getOutputCurrencyRatio(for: currencyPairs[index]) // API Requests
                currencyPairs[index].isNewPair = !currencyPairs[index].isNewPair
            }
        }
        presenter?.didRetrieveCurrencyPair(currencyPairs)
    }
    
    func getOutputCurrencyRatio(for pair: CurrencyPair) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in // 0.3 delay to allow the SelectedView to disappear
            Task(priority: .background) {
                let result = await APIService.getRates(inputCode: pair.first.shortTitle, outputCode: pair.second.shortTitle)
                switch result {
                case .success(let response):
                    pair.rate = response.rates[pair.second.shortTitle]
                    presenter?.didRetrieveCurrencyPair(currencyPairs)
                case .failure(let error):
                    self.presenter?.onError(message: error.customMessage)
                }
            }
        }
    }
}
