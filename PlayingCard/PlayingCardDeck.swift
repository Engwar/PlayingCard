//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by Igor Shelginskiy on 4/23/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    
    private(set) var cards = [PlayingCard]()
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0{
            return cards.remove(at: Int.random(in: 1..<cards.count))
        } else {
            return nil
        }
    }
    
    init () {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
}
