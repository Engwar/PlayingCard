//
//  ViewController.swift
//  PlayingCard
//
//  Created by Igor Shelginskiy on 4/23/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()
    //MARK: swipe gesture
    //создаем жест swipe(смахивание)
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left,.right]
            playingCardView.addGestureRecognizer(swipe)
        }
    }
    // MARK: pinch gesture
    //этот жест смотри  в шестой лекции Stanford IOS 11 стр. 119-120
    //MARK: tap gesture
    //размещаем жест tap(удар). Сначала перетаскиваем его из Палитры объектов, потом добавляем ctrl+action в код
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        //нам следует использовать ​switch​ по переменной ​sender.state​, которая является состоянием ​state​ РАСПОЗНАВАТЕЛЯ ЖЕСТА ​UITapGestureRecognizer​. Мы должны убедиться, что мы находимся в состоянии ​.ended​: Обычно работает  код (playingCardView.isFaceUp = !playingCardView.isFaceUp), но этот код реально более корректный для обработки жеста tap​.
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default:
            break
        }
        
    }
    //Этот целый механизм ​Target ​/ ​Action,​ который встроен в ​Objective-C​. Все методы, которые хотят быть аргументом ​action​ РАСПОЗНАВАТЕЛЯ ЖЕСТА для ​UISwipeGestureRecognizer​ должны быть помечены директивой ​@objc​. Теперь наш метод ​nextCard ()​, который написан на ​Swift​, экспонируется на ​Objective-C​ ​runtime​, который лежит в основе запуска приложений на ​iOS​. Даже если это ​Swift ​код, все равно работает Objective-C​ ​runtime​. Именно с этим связана директива ​@objc​. Поэтому все методы аргумента action​ РАСПОЗНАВАТЕЛЯ ЖЕСТА метятся как ​@objc
    @objc func nextCard () {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

