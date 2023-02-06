//
//  Extensions.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 15.08.2022.
//

import UIKit

// MARK: - Extension UIImage
// Add lightGray mask for the picture when the cell is inactive

extension UIImage {
    func change(alpha: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// MARK: - Extension Double
// Сhanges the height Font of the last two numbers in range

extension Double {
    func mutateRangeTailHeightFont() -> NSMutableAttributedString {
        
        let summaryAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Helvetica", size: 20) as Any]
        let summaryTailAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Helvetica", size: 15) as Any]
        
        let mutateSummary = NSMutableAttributedString(string: String(format: "%.4f", self), attributes: summaryAttributes)
        
        mutateSummary.addAttributes(summaryTailAttributes, range: NSRange(location: mutateSummary.length - 2, length: 2))
        return mutateSummary
    }
}

extension UIView {
    func shake(for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }

        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)

        propertyAnimator.startAnimation()
    }
}
