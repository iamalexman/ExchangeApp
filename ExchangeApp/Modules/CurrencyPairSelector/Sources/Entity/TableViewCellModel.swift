//
//  TableViewCellModel.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 11.08.2022.
//

import Foundation
import UIKit

public struct CurrencyTableViewCellModel {
    
    var titleLabel: String
    var shortTitleLabel: String
    var isChecked: Bool
    var isSelectAllowed: Bool
    var itemImage: UIImage?
    var styles: TableViewCellStyles
    
    public init(titleLabel: String,
                shortTitleLabel: String,
                isChecked: Bool,
                isSelectAllowed: Bool,
                itemImage: UIImage? = nil,
                styles:  TableViewCellStyles = .default) {
        
                self.titleLabel = titleLabel
                self.shortTitleLabel = shortTitleLabel
                self.isChecked = isChecked
                self.isSelectAllowed = isSelectAllowed
                self.itemImage = itemImage
                self.styles = styles
    }
}

public struct TableViewCellStyles {

    public var titleStyle: UIColor
    public var shortTitleStyle: UIColor

    public static var `default`: TableViewCellStyles {
        .init(titleStyle: .label, shortTitleStyle: .gray)
    }

    public static var `checked`: TableViewCellStyles {
        .init(titleStyle: .gray, shortTitleStyle: .placeholderText)
    }

    public static var defaultElevated: TableViewCellStyles {
        .default
    }

    public static var checkedElevated: TableViewCellStyles {
        .checked
    }

}

//public struct TableViewCellStyles {
//
//    public var titleStyle: UIColor
//    public var shortTitleStyle: UIColor
//    public var urlToImage: UIImage?
//
//    public static func `default`(image: UIImage?) -> TableViewCellStyles {
//        .init(titleStyle: .black, shortTitleStyle: .gray, image: image)
//    }
//
//    public static func `checked`(image: UIImage?) -> TableViewCellStyles {
//        .init(titleStyle: .black, shortTitleStyle: .gray, image: image?.change(alpha: 0.2))
//    }
//
//    public static var defaultElevated: TableViewCellStyles {
//        .default
//    }
//
//    public static var checkedElevated: TableViewCellStyles {
//        .checked
//    }
//}
