//
//  NewsEntityModel.swift
//  ExchangeApp
//
//  Created by Alex Smith on 24.08.2022.
//

import Foundation

struct NewsResponse: Codable {
    
    var status: String?
    var totalResults: Int?
    var articles: [NewsModel]?
}

struct NewsModel: Codable {
    
    var id: String?
    var name: String?
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    enum SourceKeys: String, CodingKey {
        case id
        case name
    }
    
    enum ArticlesKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ArticlesKeys.self)

        let sourceContainer = try container.nestedContainer(keyedBy: SourceKeys.self, forKey: .source)
        
        self.id = try? sourceContainer.decode(String.self, forKey: .id)
        self.name = try? sourceContainer.decode(String.self, forKey: .name)
        
        self.author = try? container.decode(String.self, forKey: .author)
        self.title = try? container.decode(String.self, forKey: .title)
        self.description = try? container.decode(String.self, forKey: .description)
        self.url = try? container.decode(String.self, forKey: .url)
        self.urlToImage = try? container.decode(String.self, forKey: .urlToImage)
        self.publishedAt = try? container.decode(String.self, forKey: .publishedAt)
        self.content = try? container.decode(String.self, forKey: .content)
    }
}
