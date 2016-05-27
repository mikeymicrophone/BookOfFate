//
//  MICCard.swift
//  Book Of Fate
//
//  Created by Mike Schwab on 5/5/16.
//  Copyright © 2016 MICharisma. All rights reserved.
//

import Foundation

class MICCard : CustomStringConvertible, Equatable, Hashable {
    let suit : String
    let face : String
    var description : String {
        return "\(face) of \(suit)"
    }

    init(suit : String, face : String) {
        self.suit = suit
        self.face = face
    }
    
    class func birthCardForMonth(month : Int, day : Int) -> MICCard {
        let position = 54 - ((month * 2) + day)
        if position == -1 {
            return MICCard(suit:"No Suit", face:"Joker")
        }
        return MICSpread.default_card_stack().objectAtIndex(position) as! MICCard
    }

    func karma_card_to_owe() -> MICCard {
        return MICSpread.natural_spread().card_in_position(MICSpread.life_spread().position_of_card(self))
    }
    
    func karma_card_owed() -> MICCard {
        return MICSpread.life_spread().card_in_position(MICSpread.natural_spread().position_of_card(self))
    }
    
    var hashValue: Int {
        return MICSpread.default_card_stack().indexOfObject(self)
    }
}

func ==(lhs: MICCard, rhs: MICCard) -> Bool {
    return lhs.suit == rhs.suit && lhs.face == rhs.face
}
