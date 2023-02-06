//
//  CurrencyPairsRatesTableViewCell.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 20.07.2022.
//

import UIKit

class CurrencyPairsRatesTableViewCell: UITableViewCell {
    
    var currency: CurrencyPair? {
        didSet {
            guard let currencyItem = currency else { return }

            titleLabel.text = currency?.first.title
            shortTitleLabel.text = "1 \(currency?.first.shortTitle ?? "")"
            secondTitleLabel.text = currency?.second.title
            secondShortTitleLabel.text = currency?.second.shortTitle
            
            guard let summary = currencyItem.rate else { return }
            
            summaryLabel.attributedText = summary.mutateRangeTailHeightFont()
        }
    }
    
    // MARK: - Initialisation
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Outlet
    
    var containerView: UIView = {
        
        let view = UIView()
        
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let summaryLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.layer.cornerRadius = 5
        label.font.withSize(8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shortTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.layer.cornerRadius = 5
        label.font.withSize(8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondShortTitleLabel:UILabel = {
        
        let label = UILabel()
        
        label.textColor =  .label
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Setup
    
    func setup() {
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(summaryLabel)
        containerView.addSubview(shortTitleLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(secondShortTitleLabel)
        containerView.addSubview(secondTitleLabel)
        
        setupConstraints()
    }
    
    // MARK: - Constraint Configuration
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            summaryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            summaryLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            shortTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            shortTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            secondShortTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            secondShortTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            secondTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            secondTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
