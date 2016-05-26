//
//  MainViewController.swift
//  Book Of Fate
//
//  Created by Mike Schwab on 5/5/16.
//  Copyright © 2016 MICharisma. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
    var outputLabel : UILabel = UILabel()
    var datePicker : UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewsAndConstraints()
    }
    
    func dateUpdated() {
        let month = NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: datePicker.date)
        let day = NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: datePicker.date)
        
        let birth_card = MICCard.birthCardForMonth(month, day: day)
        let first_karma_card = birth_card.karma_card_to_owe()
        let second_karma_card = birth_card.karma_card_owed()
        print(first_karma_card)
        print(second_karma_card)
        outputLabel.text = birth_card.description
        let grand_solar_spread = MICSpread.grand_solar_spread_for_years(1)
        let row = grand_solar_spread.row_of_card(birth_card)
        let column = grand_solar_spread.column_of_card(birth_card)
        print("row: \(row)")
        print("column: \(column)")
    }
    
    func setupViewsAndConstraints() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.addTarget(self, action: #selector(dateUpdated), forControlEvents: UIControlEvents.ValueChanged)
        view.addSubview(datePicker)
        
        self.outputLabel = UILabel()
        self.outputLabel.translatesAutoresizingMaskIntoConstraints = false
        self.outputLabel.textAlignment = NSTextAlignment.Center
        self.outputLabel.text = "Card for Date"
        view.addSubview(self.outputLabel)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[datePicker]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["datePicker": datePicker]
        ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[outputLabel]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["outputLabel": outputLabel]
            ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[datePicker(==200)][outputLabel(==80)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["datePicker": datePicker, "outputLabel": outputLabel]
        ))
    }
}