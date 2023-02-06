//
//  NewsProtocols.swift
//  ExchangeApp
//
//  Created by Alex Smith on 24.08.2022.
//

import Foundation

protocol NewsViewProtocol: AnyObject {
    
    // PRESENTER -> VIEW
    func showAlert(_ message: String)
    func reloadTableViewData()
    func showNews(_ news: [NewsModel])
}

protocol NewsPresenterProtocol: AnyObject {
    
    var newsModels: [NewsModel] { get set }
    // VIEW -> PRESENTER
    func viewDidLoad()
    func viewDidSrartRefreshing()
    func viewWillAppear()
}

protocol NewsInteractorInputProtocol: AnyObject {
    
    // PRESENTER -> INTERACTOR
    func retrieveNews()
}

protocol NewsInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func onError(message: String)
    func didRetrieveNews(news: [NewsModel])
}

protocol NewsRouterProtocol: AnyObject {
    
    static func createModule() -> NewsViewController

    // PRESENTER -> ROUTER
    func presentNewsInfo(from view: NewsViewProtocol)
}

protocol NewsInfoDelegate: AnyObject {
    
    func onSelectNewsItem(_news: NewsResponse)
}
