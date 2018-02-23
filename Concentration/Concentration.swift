//
//  Concentration.swift
//  Concentration
//
//  Created by 杨涵麟 on 22/02/2018.
//  Copyright © 2018 杨涵麟. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFacedUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].facedUp }.oneAndOnly
        }
        
        set {
            for index in cards.indices {
                cards[index].facedUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(\(index)) : index is not in the cards' indices")
        if cards[index].matched {
            return
        }
        
        if let matchIndex = indexOfOneAndOnlyFacedUpCard, index != matchIndex {
            if cards[matchIndex] == cards[index] {
                cards[matchIndex].matched = true
                cards[index].matched = true
            }
            cards[index].facedUp = true
        } else {
            indexOfOneAndOnlyFacedUpCard = index
        }
    }
    
    init(pairsOfCards: Int) {
        assert(pairsOfCards>0, "Concentration.init(\(pairsOfCards)) : at least one pair of card")
        for _ in 1...pairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        for _ in cards.indices {
            cards += [cards.remove(at: cards.count.arc4random)]
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
