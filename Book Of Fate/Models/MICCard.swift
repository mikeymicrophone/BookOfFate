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
    
    class func card_for_hour(hour : Int, on_date date : NSDate?) -> MICCard {
        var date_used = date
        if date_used == nil {
            date_used = NSDate()
        }
        let cal = NSCalendar.currentCalendar()
        let day = cal.ordinalityOfUnit(.Day, inUnit: .Year, forDate: date_used!)
        let sum = hour + day
        let offset = sum % 52
        let intermediate = (offset + 19) / 4
        let penultimate = intermediate + offset
        let quotient = penultimate / 5
        let remainder = penultimate % 5
        return hour_cards()[quotient][remainder]
    }
    
    class func hour_cards() -> [[MICCard]] {
        return [
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Spades", face:"King"), MICCard(suit:"Clubs", face:"Ten"), MICCard(suit:"Hearts", face:"King"), MICCard(suit:"Spades", face:"Two")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Hearts", face:"Ace"), MICCard(suit:"Spades", face:"Seven"), MICCard(suit:"Diamonds", face:"Five"), MICCard(suit:"Clubs", face:"Three")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Clubs", face:"Two"), MICCard(suit:"Spades", face:"Jack"), MICCard(suit:"Spades", face:"Six"), MICCard(suit:"Diamonds", face:"Four")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Diamonds", face:"Three"), MICCard(suit:"Clubs", face:"Ace"), MICCard(suit:"Hearts", face:"Jack"), MICCard(suit:"Spades", face:"Five")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Spades", face:"Four"), MICCard(suit:"Diamonds", face:"Two"), MICCard(suit:"Spades", face:"Queen"), MICCard(suit:"Hearts", face:"Ten")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Hearts", face:"Five"), MICCard(suit:"Diamonds", face:"King"), MICCard(suit:"Clubs", face:"Queen"), MICCard(suit:"Clubs", face:"Seven")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Clubs", face:"Six"), MICCard(suit:"Hearts", face:"Four"), MICCard(suit:"Diamonds", face:"Eight"), MICCard(suit:"Spades", face:"Nine")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Diamonds", face:"Seven"), MICCard(suit:"Clubs", face:"Five"), MICCard(suit:"Hearts", face:"Three"), MICCard(suit:"Diamonds", face:"Queen")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Spades", face:"Eight"), MICCard(suit:"Hearts", face:"Six"), MICCard(suit:"Diamonds", face:"Nine"), MICCard(suit:"Clubs", face:"Eight")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Hearts", face:"Nine"), MICCard(suit:"Spades", face:"Three"), MICCard(suit:"Diamonds", face:"Ace"), MICCard(suit:"Clubs", face:"Jack")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Spades", face:"Ten"), MICCard(suit:"Diamonds", face:"Six"), MICCard(suit:"Clubs", face:"Four"), MICCard(suit:"Hearts", face:"Two")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Diamonds", face:"Jack"), MICCard(suit:"Clubs", face:"Nine"), MICCard(suit:"Hearts", face:"Eight"), MICCard(suit:"Spades", face:"Ace")],
            [MICCard(suit:"No Suit", face:"Joker"), MICCard(suit:"Hearts", face:"Queen"), MICCard(suit:"Hearts", face:"Seven"), MICCard(suit:"Diamonds", face:"Ten"), MICCard(suit:"Spades", face:"King")]
        ]
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
