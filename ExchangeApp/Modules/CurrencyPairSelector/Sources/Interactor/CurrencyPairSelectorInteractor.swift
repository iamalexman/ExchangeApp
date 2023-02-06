//
//  CurrencyPairSelectorInteractor.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 26.07.2022.
//

import Foundation

class CurrencyPairSelectorInteractor: CurrencyPairSelectorInteractorInputProtocol {

    weak var presenter: CurrencyPairSelectorInteractorOutputProtocol?
    var parseService = ParseService.fetched
    var codableFactory: CodableFactory
    var storeService = LocalStore.shared
    
    var selectedCurrency: [CurrencyEntity] = []
    var currencyEntityList: [CurrencyEntity] {
        getCurrencyEntityList()
    }

    required init(presenter: CurrencyPairSelectorInteractorOutputProtocol) {
        self.presenter = presenter
        codableFactory = CodableFactory()
    }

    func getCurrencyEntityList() -> [CurrencyEntity] {
        
        var newList: [CurrencyEntity] = []
        
        parseService.getCurrencyEntitys(name: name, suffix: suffix, comletion: { [weak self] result in
            switch result {
            case .success(let result):
                newList = result.sorted(by: { $0.title < $1.title })
            case .failure(let error):
                print(error.localizedDescription)
                self?.presenter?.failure(errorMessage: error.localizedDescription)
            }
        })
        return newList
    }
              
    func checkKeyForAvailabilyty(key: String) -> Bool {
        storeService.dictionary.keys.contains(key)
    }
    
    func getSelectedCurrencies() -> [CurrencyEntity] {
        selectedCurrency
    }
    
    func addNewCurrencyToMakePair(newEntity: CurrencyEntity) {
        selectedCurrency.append(newEntity)
        if selectedCurrency.count == 2 {
            addPairToStorage(pair: selectedCurrency)
            presenter?.closeCurrencyListSelector()
        }
    }
    
    func markSelectedTags(indexPath: IndexPath, currencyModelsList: [CurrencyTableViewCellModel]) {
        
        var modifiedModels = currencyModelsList
        
        if checkKeyForAvailabilyty(key: currencyModelsList[indexPath.row].shortTitleLabel) {
            storeService.dictionary[currencyModelsList[indexPath.row].shortTitleLabel]?.forEach { value in
                for index in 0..<modifiedModels.count {
                    if value == modifiedModels[index].shortTitleLabel {
                        modifiedModels[index].isSelectAllowed = !modifiedModels[index].isSelectAllowed
                        modifiedModels[index].styles = .checked
                    }
                }
            }
        }
        presenter?.didRetrieveCurrency(modifiedModels)
    }
    
    func resetSelectedTags(currencyModelsList: [CurrencyTableViewCellModel]){
        
        var modifiedModels = currencyModelsList
        
        for index in 0..<currencyModelsList.count {
            modifiedModels[index].isSelectAllowed = false
            modifiedModels[index].styles = .default
        }
        presenter?.didRetrieveCurrency(modifiedModels)
    }
    
    func makeNewPair(newPair: CurrencyTableViewCellModel) {
        addNewCurrencyToMakePair(newEntity: makeEntityFromModel(model: newPair))
    }
    
    func retrieveCurerncyListFromParseService() {
        
        var newListEntityModels = [CurrencyTableViewCellModel]()
        
        for entity in currencyEntityList {
            newListEntityModels.append(CurrencyTableViewCellModel(titleLabel: entity.title, shortTitleLabel: entity.shortTitle, isChecked: false, isSelectAllowed: false))
        }
        presenter?.didRetrieveCurrency(newListEntityModels)
    }
    
    func addPairToStorage(pair: [CurrencyEntity]) {
        
        guard let first = pair.first?.shortTitle, let last = pair.last?.shortTitle else { return }
        
        checkKeyForAvailabilyty(key: first) ? storeService.dictionary[first]?.append(last) : (storeService.dictionary[first] = [last])
    }
    
    func makeEntityFromModel(model: CurrencyTableViewCellModel) -> CurrencyEntity {
        CurrencyEntity(title: model.titleLabel, shortTitle: model.shortTitleLabel)
    }
    
    func deleteStorageValueForKey(pair: [CurrencyEntity]) {
        
        guard let first = pair.first?.shortTitle, let last = pair.last?.shortTitle else { return }
        
        storeService.dictionary[first]?.forEach { value in
            storeService.dictionary[first] = storeService.dictionary[first]?.filter{ $0 != last }
        }
    }
}
