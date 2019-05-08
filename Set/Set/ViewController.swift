//
//  ViewController.swift
//  Set
//
//  Created by Alexandr Kurylenko on 2/12/19.
//  Copyright © 2019 Alexandr Kurylenko. All rights reserved.
//

import UIKit

struct Constant {
    static let startDealRange = 0..<12
    static let secondDealRange = 12..<24
    static let buttonRadius: CGFloat = 8.0
    static let numberOfCardToDeal = 3
    
    private init() {}
}

class ViewController: UIViewController {
    
    @IBOutlet weak var deal3CardButton: UIButton!
    @IBOutlet weak var numberOfCardsInDeckLabel: UILabel!
    @IBOutlet var cardsButtons: [UIButton]!
    
    private var deck = CardsDeck()
    private var newDeck: [Card?] = []
 
    private var card1: Card?
    private var card2: Card?
    private var card3: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstDeal()
    }
    
    private func firstDeal() {
        for index in Constant.secondDealRange {
            cardsButtons[index].isHidden = true
            cardsButtons[index].layer.cornerRadius = Constant.buttonRadius
        }
        for index in Constant.startDealRange {
            cardsButtons[index].layer.cornerRadius = Constant.buttonRadius
            cardsButtons[index].setAttributedTitle(randomCard(), for: .normal)
        }
        numberOfCardsInDeckLabel.text = "\(deck.cards.count)"
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        deck = CardsDeck()
        newDeck = []
        for button in cardsButtons {
            button.isHidden = false
        }
        firstDeal()
        deal3CardButton.isEnabled = true
    }
    
    @IBAction func deal3Card(_ sender: UIButton) {
        if deck.cards.count > 0 {
            var deal3CardCount = 0
            for button in cardsButtons {
                if button.isHidden == true, deal3CardCount < Constant.numberOfCardToDeal {
                    button.setAttributedTitle(randomCard(), for: .normal)
                    button.isHidden = false
                    deal3CardCount += 1
                }
            }
        }
        // enable Deal3Card Button
        if deck.cards.count == 0 {
            deal3CardButton.isEnabled = false
        }
        for button in cardsButtons {
            if button.isHidden == true {
                deal3CardButton.isEnabled = true
            } else {
                deal3CardButton.isEnabled = false
            }
        }
        numberOfCardsInDeckLabel.text = "\(deck.cards.count)"
    }
    
    @IBAction func chooseCard(_ sender: UIButton) {
        
        if sender.layer.borderWidth == 0 {
            sender.layer.borderWidth = 3.0
            sender.layer.borderColor = UIColor.blue.cgColor
        } else {
            sender.layer.borderWidth = 0
            sender.layer.borderColor = UIColor.white.cgColor
        }
        
        
        if let index = cardsButtons.index(of: sender) {
            if card1 == nil, sender.layer.borderColor == UIColor.blue.cgColor {
                card1 = newDeck[index]
            }
            if card1 != nil, card2 == nil, sender.layer.borderColor == UIColor.blue.cgColor {
                card2 = newDeck[index]
                if card2 == card1 {
                    card2 = nil
                }
            }
            
            if card1 != nil, card2 == nil, sender.layer.borderColor == UIColor.white.cgColor {
                card1 = nil
            }
            if card1 == nil, card2 != nil, sender.layer.borderColor == UIColor.white.cgColor {
                card2 = nil
            }
            if card1 != nil, card2 != nil, sender.layer.borderColor == UIColor.white.cgColor {
                if card1 == newDeck[index] {
                    card1 = nil
                } else if card2 == newDeck[index] {
                    card2 = nil
                }
            }
            
            if card1 != nil, card2 != nil, sender.layer.borderColor == UIColor.blue.cgColor {
                card3 = newDeck[index]
                if card3 == card1 || card3 == card2 {
                    card3 = nil
                }
                if card3 != nil, deck.set(card1: card1!, card2: card2!, card3: card3!) == false {
                    for buttons in cardsButtons {
                        buttons.layer.borderWidth = 0
                        buttons.layer.borderColor = UIColor.white.cgColor
                        card1 = nil
                        card2 = nil
                        card3 = nil
                    }
                }
                if card3 != nil, deck.set(card1: card1!, card2: card2!, card3: card3!) == true {
                    newDeck[newDeck.index(of: card1!)!] = nil
                    newDeck[newDeck.index(of: card2!)!] = nil
                    newDeck[newDeck.index(of: card3!)!] = nil

                    for buttons in cardsButtons {
                        if buttons.layer.borderColor == UIColor.blue.cgColor {
                            buttons.layer.borderWidth = 0
                            buttons.layer.borderColor = UIColor.white.cgColor
                            card1 = nil
                            card2 = nil
                            card3 = nil
                            buttons.isHidden = true
                        }
                    }
                    deal3CardButton.isEnabled = true
                }
            }
        }
    }

    private func randomCard() -> NSAttributedString? {
        // get randome card and delete it from deck
        let card: Card?
        if deck.cards.count > 0 {
            let randomIndex = Int.random(in: 0..<deck.cards.count)
            card = deck.cards.remove(at: randomIndex)
            if !newDeck.contains(nil) {
                newDeck.append(card!)
            } else {
                newDeck[newDeck.index(of: nil)!] = card
            }
        } else {
            return nil
        }
        // get symbols for card
        if let card = card {
            var printValue = ""
            if card.symbol == .circle {
                for _ in 0..<card.number.rawValue {
                    printValue += "●"
                }
            } else if card.symbol == .square {
                for _ in 0..<card.number.rawValue {
                    printValue += "◼︎"
                }
            } else {
                for _ in 0..<card.number.rawValue {
                    printValue += "▲"
                }
            }
            // set color and type for symbols in card
            let color: UIColor
            var type: [NSAttributedString.Key : Any] = [:]
            if card.color == .red {
                color = UIColor.red
            } else if card.color == .blue {
                color = UIColor.blue
            } else {
                color = UIColor.green
            }
            if card.type == .outline {
                type = [.strokeColor : color, .strokeWidth : 5.0]
            } else if card.type == .filled {
                type = [.foregroundColor : color.withAlphaComponent(1)]
            } else {
                type = [.foregroundColor : color.withAlphaComponent(0.15)]
            }
            return NSAttributedString(string: printValue, attributes: type)
        }
    }
}

