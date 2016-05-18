//
//  MICCard.swift
//  Book Of Fate
//
//  Created by Mike Schwab on 5/5/16.
//  Copyright © 2016 MICharisma. All rights reserved.
//

import Foundation

class MICCard {
    var suit : String
    var face : String
    
    init(suit : String, face : String) {
        self.suit = suit
        self.face = face
    }
    
    class func birthCardForMonth(month : Int, day : Int) -> MICCard {
        let position = 54 - ((month * 2) + day)
        return MICSpread.default_card_stack().objectAtIndex(position) as! MICCard
    }

    func matches_card(card : MICCard) -> Bool {
        if suit == card.suit {
            if face == card.face {
                return true
            }
        }
        return false
    }
}
