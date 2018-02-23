//
//  Card.swift
//  Concentration
//
//  Created by 杨涵麟 on 22/02/2018.
//  Copyright © 2018 杨涵麟. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var facedUp = false
    var matched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
