//
//  CurrencyPairSelectorPresenter.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 26.07.2022.
//

import Foundation
import UIKit

class CurrencyPairSelectorPresenter: CurrencyPairSelectorPresenterProtocol {

    weak var view: CurrencyPairSelectorViewProtocol?
    var interactor: CurrencyPairSelectorInteractorInputProtocol?
    var router: CurrencyPairSelectorRouterProtocol?
    
    weak var delegate: SelectCurrencyPairDelegate?
    var localCurrencyList: [CurrencyTableViewCellModel] = []
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {
        interactor?.retrieveCurerncyListFromParseService()
        view?.showList(localCurrencyList)
    }
    
    func viewWillAppear() {
        interactor?.retrieveCurerncyListFromParseService()
    }
    
    // MARK: - Methods
    
    func toggleSelectModel(indexPath: IndexPath) { // Сheck the cell after selecting
        
        if localCurrencyList[indexPath.row].isSelectAllowed { return } // previous items can't be selected
        
        localCurrencyList[indexPath.row].isChecked = !(localCurrencyList[indexPath.row].isChecked)
        var selectedCurrency = localCurrencyList.indices.filter({ localCurrencyList[$0].isChecked })
        
        switch selectedCurrency.count {
        case 1:
            interactor?.markSelectedTags(indexPath: indexPath, currencyModelsList: localCurrencyList)
        case 2:
            if selectedCurrency.first == indexPath.row {
                selectedCurrency.swapAt(0, 1) // swap items if the first selected item is higher in the list
            }
            selectedCurrency.forEach { index in
                interactor?.makeNewPair(newPair: localCurrencyList[index])
            }
        default:
            interactor?.resetSelectedTags(currencyModelsList: localCurrencyList)
        }
        view?.reloadTableViewData()
        updateCell(indexPath: indexPath)
    }
    
    func updateCell(indexPath: IndexPath) {
        localCurrencyList[indexPath.row].isChecked ? (localCurrencyList[indexPath.row].styles = .checked) : (localCurrencyList[indexPath.row].styles = .default)
    }
    
    func showCurrencyPairsRates() {
        guard let view = view else { return }
        router?.navigateBackToMainScreen(from: view)
    }
    
    func getCurrencies() -> [CurrencyEntity] {
        interactor?.getSelectedCurrencies() ?? []
    }
}

extension CurrencyPairSelectorPresenter: CurrencyPairSelectorInteractorOutputProtocol {
    
    // MARK: - Presenter Output Protocol
    
    func closeCurrencyListSelector() {
    
        guard let first = getCurrencies().first else { return }
        guard let last = getCurrencies().last else { return }
        
        delegate?.onSelectCurrencyData(CurrencyPair(first: first, second: last, rate: 0, isNewPair: true))
        showCurrencyPairsRates()
    }
    
    func didRetrieveCurrency(_ currencies: [CurrencyTableViewCellModel]) {
        view?.showList(currencies)
    }
    
    func success(currencies: [CurrencyTableViewCellModel]) {
        view?.showList(currencies)
    }
    
    func failure(errorMessage: String) {
        view?.showError(errorMessage)
    }
}
