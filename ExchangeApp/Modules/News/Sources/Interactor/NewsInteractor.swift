//
//  NewsInteractor.swift
//  ExchangeApp
//
//  Created by Alex Smith on 24.08.2022.
//

import Foundation

class NewsInteractor: NewsInteractorInputProtocol {
    
    var presenter: NewsInteractorOutputProtocol?
    
    var APIService: NewsServiceProtocol
    var codableFactory: CodableFactory

    var news: [NewsModel] {
        getNewsList()
    }
    
    func retrieveNews() {
        presenter?.didRetrieveNews(news: getNewsList())
    }
    
    func getNewsList() -> [NewsModel] {
        
        var newsList: [NewsModel] = []
        
        let data = codableFactory.readLocalFile(forName: "news")
        let parsedResult: NewsResponse = try! JSONDecoder().decode(NewsResponse.self, from: data!)
        
        for news in parsedResult.articles! {
            newsList.append(news)
        }
        return newsList
    }
    
    required init(presenter: NewsInteractorOutputProtocol) {
        self.presenter = presenter
        APIService = NewsService()
        codableFactory = CodableFactory()
    }
}
