//
//  NSDate.swift
//  Book Of Fate
//
//  Created by Michael Schwab on 8/7/16.
//  Copyright © 2016 MICharisma. All rights reserved.
//

import Foundation

extension NSDate {
    func card_for_hour() -> MICCard {
        let cal = NSCalendar.currentCalendar()
        let day = cal.ordinalityOfUnit(.Day, inUnit: .Year, forDate: self)
        let hour = cal.component(.Hour, fromDate: self)
        let sum = hour + day
        let offset = sum % 52
        let intermediate = (offset + 19) / 4
        let penultimate = intermediate + offset
        let quotient = penultimate / 5
        let remainder = penultimate % 5
        return NSDate.hour_cards()[quotient][remainder]
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
}
