//
//  ViewController.swift
//  Concentration
//
//  Created by 杨涵麟 on 22/02/2018.
//  Copyright © 2018 杨涵麟. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(pairsOfCards: pairsOfCards)
    
    private var pairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private var emojiChoices = "👻🎃🌷🎉🎈🎁"
    private var emoji = [Card:String]()
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? "👻🎃🌷🎉🎈🎁"
            emoji = [:]
            updateViewFromModel()
        }
    }

    // UI controllers
    @IBOutlet private weak var flipCountLabel: UILabel! { didSet { updateFlipCountLabel() } }
    @IBOutlet private var cardButtons: [UIButton]!
    
    // UI controllers' code
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        let cardNumber = cardButtons.index(of: sender)!
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    // Self-defined functions' code
    private func updateViewFromModel() {
        if cardButtons == nil {
            return
        }
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.facedUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.matched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
        }
        
        return emoji[card]!
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flip: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
}

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}

