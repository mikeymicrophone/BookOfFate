//
//  MICSpread.swift
//  Book Of Fate
//
//  Created by Mike Schwab on 5/5/16.
//  Copyright © 2016 MICharisma. All rights reserved.
//

import Foundation
import UIKit

class MICSpread : CustomStringConvertible {
    var cards : NSArray = []
    var colored_spread : NSMutableAttributedString?
    
    init(card_pile : NSArray) {
        self.cards = card_pile
    }
    
    class func suits() -> Array<String> {
        return ["Hearts", "Clubs", "Diamonds", "Spades"]
    }
    
    class func faces() -> Array<String> {
        return ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    }
    
    class func default_card_stack() -> NSMutableArray {
        let cards = NSMutableArray()
        
        for suit in suits() {
            for face in faces() {
                cards.addObject(MICCard(suit: suit, face: face))
            }
        }
        return cards
    }
    
    class func grand_solar_spread_for_years(years : Int) -> MICSpread {
        var card_pile : NSArray = default_card_stack().reverse()
        
        for _ in 0..<years {
            var hearts_pile = NSMutableArray()
            var clubs_pile = NSMutableArray()
            var diamonds_pile = NSMutableArray()
            var spades_pile = NSMutableArray()
            var top_card = 51
            
            for _ in suits() {
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
            top_card = 51
            
            for _ in faces() {
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

    class func natural_spread() -> MICSpread {
        return MICSpread(card_pile: default_card_stack())
    }
    
    class func life_spread() -> MICSpread {
        return MICSpread(card_pile: grand_solar_spread_for_years(1).cards)
    }
    
    func position_of_card(card : MICCard) -> MICPosition {
        return MICPosition(spread: self, card: card)
    }
    
    func card_in_position(position : MICPosition) -> MICCard {
        var row = rows()[position.vertical_position]
        return row[position.horizontal_position]
    }
    
    func position_beyond_card(card : MICCard, by_places places : Int) -> MICPosition {
        return position_of_card(card).position_with_displacement(places)
    }

    func environment_card_for_card(card : MICCard) -> MICCard {
        return card_in_position(MICSpread.life_spread().position_of_card(card))
    }
    
    func row_of_card(card : MICCard) -> Int {
        for row_index in 0..<(rows().count) {
            let row = rows()[row_index]
            for position in row {
                if card == position {
                    return row_index
                }
            }
        }
        return 0
    }

    func column_of_card(card : MICCard) -> Int {
        for row_index in 0..<(rows().count) {
            let row = rows()[row_index]
            for position in row {
                if card == position {
                    return row.indexOf(position)!
                }
            }
        }
        return 0
    }

    func rows() -> [[MICCard]] {
        let row_group = NSMutableArray()
        var spread_position = 0
        
        for _ in [0,1,2,3,4,5,6] {
            let card_range = NSMakeRange(spread_position, 7)
            let cards_for_row = NSIndexSet(indexesInRange: card_range)
            let planetary_group = cards.objectsAtIndexes(cards_for_row)
            row_group.addObject(planetary_group)
            spread_position += 7
        }
        
        let ruling_group = NSMutableArray()
        ruling_group.addObject(cards.objectAtIndex(49))
        ruling_group.addObject(cards.objectAtIndex(50))
        ruling_group.addObject(cards.objectAtIndex(51))
        row_group.addObject(ruling_group)
        return row_group as! [[MICCard]]
    }
    
    func direct_cards_for_card(birth_card : MICCard) -> [MICPlanet:MICCard] {
        var direct_cards = [MICPlanet:MICCard]()
        direct_cards[.Mercury] = card_in_position(position_beyond_card(birth_card, by_places: 1))
        direct_cards[.Venus] = card_in_position(position_beyond_card(birth_card, by_places: 2))
        direct_cards[.Mars] = card_in_position(position_beyond_card(birth_card, by_places: 3))
        direct_cards[.Jupiter] = card_in_position(position_beyond_card(birth_card, by_places: 4))
        direct_cards[.Saturn] = card_in_position(position_beyond_card(birth_card, by_places: 5))
        direct_cards[.Uranus] = card_in_position(position_beyond_card(birth_card, by_places: 6))
        direct_cards[.Neptune] = card_in_position(position_beyond_card(birth_card, by_places: 7))
        return direct_cards
    }
    
    func planet_for_card(card : MICCard, month : Int, day : Int) -> MICPlanet {
        let calendar = NSCalendar.currentCalendar()
        let current_date = NSDate()
        let current_month = calendar.component(.Month, fromDate:current_date)
        let last_birthday = NSDateComponents()
        if current_month > month {
            last_birthday.year = 2016
        } else if current_month == month {
            let current_day = calendar.component(.Day, fromDate:current_date)
            if current_day < day {
                last_birthday.year = 2015
            } else {
                last_birthday.year = 2016
            }
        } else {
            last_birthday.year = 2015
        }
        last_birthday.month = month
        last_birthday.day = day
        let birthday = calendar.dateFromComponents(last_birthday)
        let days_since_birthday = calendar.components(.Day, fromDate: birthday!, toDate: current_date, options: []).day
        var planets_since_birthday = days_since_birthday / 52
        if planets_since_birthday == 7 {
            planets_since_birthday = 6
        }
        return MICPlanet.planets[planets_since_birthday]
    }
    
    func planetary_card_for_card(card : MICCard, month : Int, day : Int) -> MICCard {
        return direct_cards_for_card(card)[planet_for_card(card, month: month, day: day)]!
    }
    
    func birthday_grid() -> [MICCard:NSMutableArray] {
        let calendar = NSCalendar.currentCalendar()
        var current_day = NSDateComponents()
        current_day.year = 2016
        current_day.month = 1
        current_day.day = 1
        var day = calendar.dateFromComponents(current_day)
        let days_of_the_year = NSMutableArray()
        let a_day = NSDateComponents()
        a_day.day = 1
        while current_day.year == 2016 {
            days_of_the_year.addObject(day!)
            day = calendar.dateByAddingComponents(a_day, toDate: day!, options:NSCalendarOptions.init())
            current_day = calendar.components([.Day, .Month, .Year], fromDate: day!)
        }
        
        var cards_for_birthdays = [NSDate:MICCard]()
        var numerals = NSDateComponents()
        for birthday in days_of_the_year {
            numerals = calendar.components([.Month, .Day], fromDate: birthday as! NSDate)
            cards_for_birthdays[birthday as! NSDate] = MICCard.birthCardForMonth(numerals.month, day: numerals.day)
        }
        
        var birthdays_for_card = [MICCard:NSMutableArray]()
        var birthdays = NSMutableArray()
        let deck = MICSpread.default_card_stack()
        for card in deck {
            for (date, birth_card) in cards_for_birthdays {
                if card as! MICCard == birth_card {
                    birthdays.addObject(date)
                }
            }
            let orderedBirthdays : NSMutableArray = NSMutableArray()
            orderedBirthdays.addObjectsFromArray(birthdays.sort({ first, second in
                (first as! NSDate).timeIntervalSince1970 < (second as! NSDate).timeIntervalSince1970
            }))
            birthdays_for_card[card as! MICCard] = orderedBirthdays
            birthdays = NSMutableArray()
        }
        return birthdays_for_card
    }
    
    func karmic_helpers_text(card : MICCard, title : String) -> String {
        let dates = birthday_grid()[card]
        var text = "\(title) \(card.description); people born on "
        let dateFormatter = NSDateFormatter()
        let october = NSDateComponents()
        october.year = 2016
        october.month = 10
        october.day = 1
        let cutoff = NSCalendar.currentCalendar().dateFromComponents(october)
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .ShortStyle
        for date in dates! {
            var dateString : NSString = dateFormatter.stringFromDate(date as! NSDate)
            if date.compare(cutoff!) == .OrderedAscending {
                dateString = dateString.substringToIndex(4)
            } else {
                dateString = dateString.substringToIndex(5)
            }
            if dateString.characterAtIndex(dateString.length - 1) == "/".characterAtIndex(0) {
                dateString = dateString.substringToIndex(dateString.length - 1)
            }
            text = text + (dateString as String) + ", "
        }
        return text
    }
    
    var description : String {
        var text = ""
        for row in rows() {
            for card in row {
                text = text + " " + card.abbreviation()
            }
        }
        return text
    }

    func ascii_spread() -> String {
        var ascii : String = ""
        let ruling_group = rows()[7]
        for card in ruling_group.reverse() {
            ascii += card.abbreviation() + "|"
        }
        ascii.removeAtIndex(ascii.endIndex.predecessor())
        ascii += "\n"
        
        var planetary_group : Array<MICCard>
        for row in 0..<7 {
            planetary_group = rows()[row]
            for card in planetary_group.reverse() {
                ascii += card.abbreviation() + "|"
            }
            ascii.removeAtIndex(ascii.endIndex.predecessor())
            ascii += "\n"
        }
        return ascii
    }

    func colored_ascii() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: ascii_spread())
    }

    func color_card(card : MICCard, with_color color : UIColor) {
        if colored_spread == nil {
            colored_spread = colored_ascii()
        }
        let colored_range = NSMakeRange(position_of_card(card).ascii_position(), 2)
        colored_spread?.addAttribute(NSForegroundColorAttributeName, value: color, range: colored_range)
    }

    func colored_ascii_spread_for(birth_card : MICCard) -> NSMutableAttributedString {
        color_card(birth_card, with_color: UIColor.greenColor())
        color_card(birth_card.karma_card_owed(), with_color: UIColor.redColor())
        color_card(birth_card.karma_card_to_owe(), with_color: UIColor.brownColor())
        color_card(birth_card.pluto_card_for_age(birth_card.age!), with_color: UIColor.cyanColor())
        color_card(birth_card.result_card_for_age(birth_card.age!), with_color: UIColor.darkGrayColor())
        return colored_spread!
    }

    func unicode_spread() -> String {
        var unicode : String = ""
        let ruling_group = rows()[7]
        for card in ruling_group.reverse() {
            unicode += String(card.unicode_character())
        }
        unicode += "\n"
        
        var planetary_group : Array<MICCard>
        for row in 0..<7 {
            planetary_group = rows()[row]
            for card in planetary_group.reverse() {
                unicode += String(card.unicode_character())
            }
            unicode += "\n"
        }
        return unicode
    }
}
