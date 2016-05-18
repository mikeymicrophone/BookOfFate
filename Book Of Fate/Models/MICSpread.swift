//
//  MICSpread.swift
//  Book Of Fate
//
//  Created by Mike Schwab on 5/5/16.
//  Copyright © 2016 MICharisma. All rights reserved.
//

import Foundation

class MICSpread {
    var cards : NSArray = []
    
    init(card_pile : NSArray) {
        self.cards = card_pile
    }
    
    class func default_card_stack() -> NSArray {
        let cards : NSMutableArray = NSMutableArray()
        let suits = ["Hearts", "Clubs", "Diamonds", "Spades"]
        let faces = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
        
        for (suit) in suits {
            for (face) in faces {
                cards.addObject(MICCard(suit: suit, face: face))
            }
        }
        return cards
    }
    
    class func grand_solar_spread_for_years(years : Int) -> MICSpread {
        var card_pile : NSArray = default_card_stack().reverse()
        
        for(var i = 0; i < years; i++) {
            var hearts_pile = NSMutableArray()
            var clubs_pile = NSMutableArray()
            var diamonds_pile = NSMutableArray()
            var spades_pile = NSMutableArray()
            var top_card = 51
            
            for j in [0,1,2,3] {
                hearts_pile.addObject(card_pile.objectAtIndex(top_card - 2))
                hearts_pile.addObject(card_pile.objectAtIndex(top_card - 1))
                hearts_pile.addObject(card_pile.objectAtIndex(top_card))
                clubs_pile.addObject(card_pile.objectAtIndex(top_card - 5))
                clubs_pile.addObject(card_pile.objectAtIndex(top_card - 4))
                clubs_pile.addObject(card_pile.objectAtIndex(top_card - 3))
                diamonds_pile.addObject(card_pile.objectAtIndex(top_card - 8))
                diamonds_pile.addObject(card_pile.objectAtIndex(top_card - 7))
                diamonds_pile.addObject(card_pile.objectAtIndex(top_card - 6))
                spades_pile.addObject(card_pile.objectAtIndex(top_card - 11))
                spades_pile.addObject(card_pile.objectAtIndex(top_card - 10))
                spades_pile.addObject(card_pile.objectAtIndex(top_card - 9))
                top_card = top_card - 12
            }
            
            hearts_pile.addObject(card_pile.objectAtIndex(3))
            clubs_pile.addObject(card_pile.objectAtIndex(2))
            diamonds_pile.addObject(card_pile.objectAtIndex(1))
            spades_pile.addObject(card_pile.objectAtIndex(0))
            
            hearts_pile.addObjectsFromArray(clubs_pile as [AnyObject])
            hearts_pile.addObjectsFromArray(diamonds_pile as [AnyObject])
            hearts_pile.addObjectsFromArray(spades_pile as [AnyObject])
            card_pile = hearts_pile
            
            hearts_pile = []
            clubs_pile = []
            diamonds_pile = []
            spades_pile = []
            
            for _ in [0,1,2,3,4,5,6,7,8,9,10,11,12] {
                hearts_pile.addObject(card_pile.objectAtIndex(top_card))
                clubs_pile.addObject(card_pile.objectAtIndex(top_card - 1))
                diamonds_pile.addObject(card_pile.objectAtIndex(top_card - 2))
                spades_pile.addObject(card_pile.objectAtIndex(top_card - 3))
                top_card = top_card - 4
            }
            
            hearts_pile.addObjectsFromArray(clubs_pile as [AnyObject])
            hearts_pile.addObjectsFromArray(diamonds_pile as [AnyObject])
            hearts_pile.addObjectsFromArray(spades_pile as [AnyObject])
            card_pile = hearts_pile
        }
        
        return MICSpread(card_pile: card_pile.reverse())
    }
}
