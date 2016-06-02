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
        var final_position : MICPosition?
        if (self.vertical_position == 7) {
            if ((self.horizontal_position + places) < 3) {
                final_position = MICPosition(row:vertical_position, column:horizontal_position + places);
            } else {
                let horizontal = ((horizontal_position + places - 3) % 7);
                let vertical = ((horizontal_position + places - 3) / 7);
                final_position = MICPosition(row:vertical, column:horizontal)
            }
        } else if (self.vertical_position == 6) {
            if ((self.horizontal_position + places) < 7) {
                final_position = MICPosition(row:vertical_position, column:horizontal_position + places)
            } else if ((self.horizontal_position + places) < 10) {
                final_position = MICPosition(row:7, column:horizontal_position)
            } else {
                let horizontal = (self.horizontal_position + places) - 10;
                let vertical = horizontal / 7;
                final_position = MICPosition(row:vertical, column:horizontal)
            }
        } else {
            if ((self.horizontal_position + places) < 7) {
                final_position = MICPosition(row: vertical_position, column: horizontal_position + places)
            } else if ((self.horizontal_position + places) < 14) {
                final_position = MICPosition(row: vertical_position + 1, column:(horizontal_position + places) % 7)
            }
        }
        
        final_position!.spread = spread
        final_position!.card = spread?.card_in_position(final_position!)
        
        return final_position!
    }

    func ascii_position() -> Int {
        var starting_position : Int
        if vertical_position == 7 {
            starting_position = (6 - horizontal_position * 3)
        } else {
            starting_position = (vertical_position * 21 + (18 - horizontal_position * 3)) + 9
        }
        return starting_position
    }    
}
