//
//  NewsRouter.swift
//  ExchangeApp
//
//  Created by Alex Smith on 24.08.2022.
//

import Foundation
import UIKit

class NewsRouter: NewsRouterProtocol {
    
    static func createModule() -> NewsViewController {
        
        let view = NewsViewController()
        let presenter = NewsPresenter()
        let interactor = NewsInteractor(presenter: presenter)
        let router = NewsRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
//        presenter.delegate = delegate
        
        return view
    }
    
    func presentNewsInfo(from view: NewsViewProtocol) {
        
//        let newsInfo = NewsInfoRouter.createModule(delegate: delegate)
//        guard let newsList = view as? UIViewController else {
//            fatalError("Invalid view Protocol type")
//        }
//        newsList.navigationController?.present(newsInfo, animated: true)
    }
}
