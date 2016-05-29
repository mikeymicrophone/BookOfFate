//
//  MICPosition.swift
//  Book Of Fate
//
//  Created by Michael Schwab on 5/25/16.
//  Copyright © 2016 MICharisma. All rights reserved.
//

import Foundation

class MICPosition {
    var spread : MICSpread?
    var card : MICCard?
    var vertical_position : Int
    var horizontal_position : Int
    
    init(spread : MICSpread, card : MICCard) {
        self.spread = spread
        self.card = card
        vertical_position = spread.row_of_card(card)
        horizontal_position = spread.column_of_card(card)
    }
    
    init(row : Int, column : Int) {
        vertical_position = row
        horizontal_position = column
    }
    
    func position_with_displacement(places : Int) -> MICPosition {
        print(spread)
        
        let position = MICPosition(row:vertical_position + 1, column:horizontal_position - 1)
        position.spread = spread
        position.card = spread?.card_in_position(position)
        
        return position
    }
}
