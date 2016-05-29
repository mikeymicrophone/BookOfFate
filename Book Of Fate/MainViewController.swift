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
    var karma_helpers_label = UILabel()
    var karma_helpees_label = UILabel()
    
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
        outputLabel.text = birth_card.description
        let grand_solar_spread = MICSpread.grand_solar_spread_for_years(1)
        let birthday_list = grand_solar_spread.birthday_grid()
        let karmic_helpers = birthday_list[first_karma_card]
        let karmic_helpees = birthday_list[second_karma_card]
        karma_helpers_label.text = grand_solar_spread.karmic_helpers_text(first_karma_card)
//        print("Karmic helpers: ", first_karma_card)
//        print(karmic_helpers)
//        print("Karmic helpees", second_karma_card)
//        print(karmic_helpees)
        print(grand_solar_spread)
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
        self.karma_helpers_label = UILabel()
        karma_helpers_label.translatesAutoresizingMaskIntoConstraints = false
        karma_helpers_label.textAlignment = .Center
        karma_helpers_label.numberOfLines = 12
        view.addSubview(karma_helpers_label)
        
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
            "V:|[datePicker(==200)][outputLabel(==80)][karma_helpers_label(==300)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["datePicker": datePicker, "outputLabel": outputLabel, "karma_helpers_label": karma_helpers_label]
        ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[karma_helpers_label]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["karma_helpers_label": karma_helpers_label]
            ))
    }
}