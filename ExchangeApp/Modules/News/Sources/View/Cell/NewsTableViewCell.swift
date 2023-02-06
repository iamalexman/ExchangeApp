//
//  NewsTableViewCell.swift
//  ExchangeApp
//
//  Created by Alex Smith on 24.08.2022.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var news: NewsModel? {
        didSet {
//            guard let newsItem = news else { return }
//            titleLabel.text = news?.title
//            publishedAt.text = news?.publishedAt
//            image.startAnimating()
        }
    }
    
    // MARK: - Initialisation
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        image.image = nil
//    }
    
    // MARK: - Outlets
    
    var publishedAt: UILabel = {
        
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var image: ShimmerView = {
        
        let imageView = ShimmerView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: 110, height: 110)
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Setup
    
    func setup() {
        
        contentView.addSubview(image)
        contentView.addSubview(publishedAt)
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    // MARK: - Constraint Configuration
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            contentView.heightAnchor.constraint(equalToConstant: 130),
            
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            image.widthAnchor.constraint(equalToConstant: 110),
            image.heightAnchor.constraint(equalToConstant: 110),
        
            titleLabel.topAnchor.constraint(equalTo: image.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        
            publishedAt.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            publishedAt.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            publishedAt.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
        ])
    }
    
    // MARK: - Methods
    
    func update(model: NewsModel) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        titleLabel.text = model.title
        publishedAt.text = model.publishedAt
        image.startAnimating()
//        image.image = image.load(url: model.urlToImage)
//        }
    }
}
