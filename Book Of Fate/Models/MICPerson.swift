//
//  MICPerson.swift
//  Book Of Fate
//
//  Created by Michael Schwab on 8/7/16.
//  Copyright © 2016 MICharisma. All rights reserved.
//

import Foundation

class MICPerson {
    var birth_card : MICCard
    var birth_date : NSDate
    var first_name : String?
    var last_name : String?
    var age : Int
    
    init(birth_date : NSDate) {
        self.birth_date = birth_date
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.component(.Month, fromDate: birth_date)
        let day = calendar.component(.Day, fromDate: birth_date)
        self.birth_card = MICCard.birthCardForMonth(month, day: day)
        
        let seconds = birth_date.timeIntervalSinceNow
        self.age = Int(seconds / (-60*60*24*365.25))
    }

    func long_range_spread() -> MICSpread {
        let ordinal = (age / 7) + 1
        return MICSpread.grand_solar_spread_for_years(ordinal)
    }
    
    func long_range_card() -> MICCard {
        let spread = long_range_spread()
        let offset = (age % 7) + 1
        return spread.card_in_position(spread.position_beyond_card(birth_card, by_places:offset))
    }
}
