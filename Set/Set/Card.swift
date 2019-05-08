//
//  Card.swift
//  Set
//
//  Created by Alexandr Kurylenko on 2/12/19.
//  Copyright © 2019 Alexandr Kurylenko. All rights reserved.
//

import Foundation

struct Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color.rawValue == rhs.color.rawValue && lhs.number.rawValue == rhs.number.rawValue && lhs.symbol.rawValue == rhs.symbol.rawValue && lhs.type.rawValue == rhs.type.rawValue
    }
    
    let symbol: Symbol
    let number: Number
    let color: Color
    let type: Types
    
    enum Symbol: Int {
        case circle = 1
        case square = 2
        case triangle = 3
        
        static let all = [Symbol.circle, .square, .triangle]
    }
    
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
        
        static let all = [Number.one, .two, .three]
    }
    
    enum Color: Int {
        case red = 1
        case blue = 2
        case green = 3
        
        static let all = [Color.red, .blue, .green]
    }
    
    enum Types: Int {
        case outline = 1
        case filled = 2
        case striped = 3
        
        static let all = [Types.outline, .filled, .striped]
    }
}


