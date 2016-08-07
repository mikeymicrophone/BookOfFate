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
    var age : Int?
    var description : String {
        return "\(face) of \(suit)"
    }
    
    func abbreviation() -> String {
        let suit_abbreviation = ["Hearts": "H", "Clubs": "C", "Diamonds": "D", "Spades": "S", "No Suit": "J"][suit]
        let face_abbreviation = ["Ace": "A", "Two": "2", "Three": "3", "Four": "4", "Five": "5", "Six": "6", "Seven": "7", "Eight": "8", "Nine": "9", "Ten": "T", "Jack": "J", "Queen": "Q", "King": "K", "Joker": "J"][face]
        return face_abbreviation! + suit_abbreviation!
    }
    
    func unicode_character() -> Character {
        let suit_bit = ["Hearts": 0xB0, "Clubs": 0xD0, "Diamonds": 0xC0, "Spades": 0xA0, "No Suit": 0xD0][suit]
        let face_bit = ["Ace": 0x1, "Two": 0x2, "Three": 0x3, "Four": 0x4, "Five": 0x5, "Six": 0x6, "Seven": 0x7, "Eight": 0x8, "Nine": 0x9, "Ten": 0xA, "Jack": 0xB, "Queen": 0xD, "King": 0xE, "Joker": 0xF][face]
        let code_base = 0x1F000
        let code = code_base + suit_bit! + face_bit!
        return Character(UnicodeScalar(code))
    }
    
    func unicode_suit_character() -> Character {
        let suit_code : Int = ["Hearts": 0x2661, "Clubs": 0x2663, "Diamonds": 0x2662, "Spades": 0x2660, "No Suit": 2672][suit]!
        return Character(UnicodeScalar(suit_code))
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
