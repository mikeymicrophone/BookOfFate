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
    
    func abbreviation() -> String {
        let suit_abbreviation = ["Hearts": "H", "Clubs": "C", "Diamonds": "D", "Spades": "S", "No Suit": "J"][suit]
        let face_abbreviation = ["Ace": "A", "Two": "2", "Three": "3", "Four": "4", "Five": "5", "Six": "6", "Seven": "7", "Eight": "8", "Nine": "9", "Ten": "T", "Jack": "J", "Queen": "Q", "King": "K", "Joker": "J"][face]
        return face_abbreviation! + suit_abbreviation!
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

    func long_range_card_for_age(age : Int) -> MICCard {
        let era_spread = MICSpread.grand_solar_spread_for_years(age)
        var range = 0
        if age % 7 == 0 {
            range = 7
        } else {
            range = age % 7
        }
        let long_range_card : MICCard = era_spread.card_in_position(era_spread.position_beyond_card(self, by_places:range))
        return long_range_card
    }
    
    func pluto_card_for_age(age : Int) -> MICCard {
        let era_spread = MICSpread.grand_solar_spread_for_years(age)
        let pluto_card : MICCard = era_spread.card_in_position(era_spread.position_beyond_card(self, by_places:8))
        return pluto_card
    }

    func result_card_for_age(age : Int) -> MICCard {
        let era_spread = MICSpread.grand_solar_spread_for_years(age)
        let result_card : MICCard = era_spread.card_in_position(era_spread.position_beyond_card(self, by_places:9))
        return result_card
    }
    
    var hashValue: Int {
        return MICSpread.default_card_stack().indexOfObject(self)
    }
}

func ==(lhs: MICCard, rhs: MICCard) -> Bool {
    return lhs.suit == rhs.suit && lhs.face == rhs.face
}
