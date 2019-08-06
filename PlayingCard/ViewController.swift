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

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
            print("\(card)")
            }
        }
    }


}

