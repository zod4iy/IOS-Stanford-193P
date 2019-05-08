//
//  CardsDeck.swift
//  Set
//
//  Created by Alexandr Kurylenko on 2/13/19.
//  Copyright © 2019 Alexandr Kurylenko. All rights reserved.
//

import Foundation

struct CardsDeck {
    var cards = [Card]()
    init () {
        for symbol in Card.Symbol.all {
            for number in Card.Number.all {
                for color in Card.Color.all {
                    for type in Card.Types.all {
                        cards.append(Card(symbol: symbol, number: number, color: color, type: type))
                    }
                }
            }
        }
    }
    
    func set(card1: Card, card2: Card, card3: Card) -> Bool {
        var count = 0
        if card1.color.rawValue == card2.color.rawValue && card1.color.rawValue == card3.color.rawValue {
            count += 1
        } else if card1.color.rawValue != card2.color.rawValue && card1.color.rawValue != card3.color.rawValue && card2.color.rawValue != card3.color.rawValue {
            count += 1
        }
        if card1.number.rawValue == card2.number.rawValue && card1.number.rawValue == card3.number.rawValue {
            count += 1
        } else if card1.number.rawValue != card2.number.rawValue && card1.number.rawValue != card3.number.rawValue && card2.number.rawValue != card3.number.rawValue {
            count += 1
        }
        if card1.symbol.rawValue == card2.symbol.rawValue && card1.symbol.rawValue == card3.symbol.rawValue {
            count += 1
        } else if card1.symbol.rawValue != card2.symbol.rawValue && card1.symbol.rawValue != card3.symbol.rawValue && card2.symbol.rawValue != card3.symbol.rawValue {
            count += 1
        }
        if card1.type.rawValue == card2.type.rawValue && card1.type.rawValue == card3.type.rawValue {
            count += 1
        } else if card1.type.rawValue != card2.type.rawValue && card1.type.rawValue != card3.type.rawValue && card2.type.rawValue != card3.type.rawValue {
            count += 1
        }
        
        if count == 4 {
            return true
        } else {
            return false
        }
    }
}
