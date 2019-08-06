//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Igor Shelginskiy on 4/30/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit
@IBDesignable //позволяет видеть отображение изменения в сториборде

class PlayingCardView: UIView {
    
    @IBInspectable // позволяет изменять значение текущей строки прямо на панели испекторов
    var rank: Int = 5 { didSet { setNeedsDisplay(); setNeedsLayout() }}
    @IBInspectable
    var suit: String = "♥️" { didSet { setNeedsDisplay(); setNeedsLayout() }}
    @IBInspectable
    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() }}
    
    // создаем функцию создания угла карты, центрирования  масти и достоинства в углу  карты
    private func centeredAttributeString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize) // создаем шрифт
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font) // здесь мы делаем так чтобы при изменении ползунка настройки величины текста(General -> Accessibility -> LargerText, наш текст менял размер
        let paragraphStyle = NSMutableParagraphStyle() // создаем выравнивание текста
        paragraphStyle.alignment = .center // выравнивание по центру по горизонтали
        
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle,.font: font])
    }
    
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
    
    private var cornerString: NSAttributedString {
        return centeredAttributeString(rankString + "\n" + suit, fontSize: cornerFontSize)
    }
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0 // размещаем столько строк сколько нужно, можно поставить 2
        addSubview(label)
        return label
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { //с помощью переопределения этого метода делаем так чтобы размер шрифта менялся сразу при изменеении ползунка в настройках а не после поворота экрана
        setNeedsLayout()
        setNeedsDisplay()
    }

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        configureCornerLabel(lowerRightCornerLabel)
        lowerRightCornerLabel.transform = CGAffineTransform.identity.translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height).rotated(by: .pi)
        
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
        .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
        .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.height)
    }
    
    private func configureCornerLabel(_ label: UILabel) {
        label.attributedText = cornerString
        label.frame.size = CGSize.zero // сначала обнуляем размер
        label.sizeToFit() // потом заново возводим размер метки,чтобы расширить ее в обеих направлениях, иначе если метка ​label​ уже имеет некоторую ширину ​width​, то метод ​sizeToFit()​ сделает ее выше, но сохранит ее ширину ​width
        label.isHidden = !isFaceUp
    }
}



extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085 //размер шрифта для метки в углу карты по отношению к высоте карты
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06 //радиус угла карты по отношению к высоте карты
        static let cornerOffsetToCornerRadius: CGFloat = 0.33 //смещение угла по отношению к радиусу угла карты
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75 //размер изображения “картинки” для карт с “картинкой” по отношению к размеру карты
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var rankString: String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth)/2, dy: (height - newHeight)/2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}
