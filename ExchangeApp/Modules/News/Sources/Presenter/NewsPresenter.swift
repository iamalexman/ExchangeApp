//
//  NewsPresenter.swift
//  ExchangeApp
//
//  Created by Alex Smith on 24.08.2022.
//

import Foundation
import UIKit

class NewsPresenter: NewsPresenterProtocol {
    
    weak var view: NewsViewProtocol?
    var router: NewsRouterProtocol?
    var interactor: NewsInteractorInputProtocol?
    
    var newsModels: [NewsModel] = []

    func viewDidLoad() {
        interactor?.retrieveNews()
        view?.showNews(newsModels)
    }
        
    func viewDidSrartRefreshing() {
        interactor?.retrieveNews()
    }
    
    func viewWillAppear() {
        interactor?.retrieveNews()
    }
}

extension NewsPresenter: NewsInteractorOutputProtocol {
    
    func onError(message: String) {
        view?.showAlert(message)
    }
    
    func showMessage(message: String) {
        view?.showAlert(message)
    }
    
    func didRetrieveNews(news: [NewsModel]) {
        view?.showNews(news)
    }
}

extension NewsPresenter: NewsInfoDelegate {
    
    func onSelectNewsItem(_news: NewsResponse) {
    
    }
}

