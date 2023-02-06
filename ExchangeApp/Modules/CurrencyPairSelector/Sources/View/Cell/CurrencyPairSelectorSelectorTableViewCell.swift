//
//  CurrencyPairSelectorTableViewCell.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 20.07.2022.
//

import UIKit

class CurrencyPairSelectorTableViewCell: UITableViewCell {
    
    private var styles: TableViewCellStyles = .default {
        didSet {
            titleLabel.textColor = styles.titleStyle
            shortTitleLabel.textColor = styles.shortTitleStyle
        }
    }
    
    // MARK: - Initialisation
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        flagImage.image = nil
    }
    
    // MARK: - Outlet
    
    let containerView: UIView = {
        
        let view = UIView()
        
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var shortTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let flagImage: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Setup
    
    func setup() {
        
        containerView.addSubview(shortTitleLabel)
        containerView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        contentView.addSubview(flagImage)
        
        setupConstraints()
    }
    
    // MARK: - Constraint Configuration
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            flagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            flagImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            flagImage.widthAnchor.constraint(equalToConstant: 30),
            flagImage.heightAnchor.constraint(equalToConstant: 30),
        
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalToConstant: 30),
        
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: shortTitleLabel.trailingAnchor, constant: 15),
        
            shortTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            shortTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
    
    // MARK: - Methods
    
    func update(model: CurrencyTableViewCellModel) {
        
        titleLabel.text = model.titleLabel
        shortTitleLabel.text = model.shortTitleLabel
        flagImage.image = UIImage(named: model.shortTitleLabel)
        styles = model.styles
        
        if model.isSelectAllowed || model.isChecked {
            flagImage.image = flagImage.image?.change(alpha: 0.2)
        }
        accessoryType = model.isChecked ? .checkmark : .none
        tintColor = UIColor(named: "AccentColor")
        selectionStyle = .none
    }
}
