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
    var spread_label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewsAndConstraints()
    }
    
    func dateUpdated() {
        let month = NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: datePicker.date)
        let day = NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: datePicker.date)
        let seconds : NSTimeInterval = datePicker.date.timeIntervalSinceNow
        let age = Int(seconds / (-60*60*24*365.25) + 1)
        let birth_card = MICCard.birthCardForMonth(month, day: day)
        birth_card.age = age
        let first_karma_card = birth_card.karma_card_to_owe()
        outputLabel.text = birth_card.description
        let grand_solar_spread = MICSpread.grand_solar_spread_for_years(age)
        karma_helpers_label.text = grand_solar_spread.karmic_helpers_text(first_karma_card)
        print(grand_solar_spread.unicode_spread())
        spread_label.text = grand_solar_spread.unicode_spread()
        let card_for_hour = MICCard.card_for_hour(10, on_date : NSDate())
    }
    
    func setupViewsAndConstraints() {
        view.backgroundColor = UIColor.whiteColor()
        
        datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.addTarget(self, action: #selector(dateUpdated), forControlEvents: UIControlEvents.ValueChanged)
        view.addSubview(datePicker)
        
        outputLabel = UILabel()
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.textAlignment = NSTextAlignment.Center
        outputLabel.text = "Card for Date"
        view.addSubview(outputLabel)
        karma_helpers_label = UILabel()
        karma_helpers_label.translatesAutoresizingMaskIntoConstraints = false
        karma_helpers_label.textAlignment = .Center
        karma_helpers_label.numberOfLines = 12
        view.addSubview(karma_helpers_label)
        spread_label = UILabel()
        spread_label.translatesAutoresizingMaskIntoConstraints = false
        spread_label.textAlignment = .Center
        spread_label.numberOfLines = 12
        spread_label.font = UIFont(name: "DejaVuSans", size: 14)
        view.addSubview(spread_label)
        
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
            "V:|[datePicker(==150)][outputLabel(==40)][spread_label(==200)][karma_helpers_label(==300)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["datePicker": datePicker, "outputLabel": outputLabel, "karma_helpers_label": karma_helpers_label, "spread_label": spread_label]
        ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[karma_helpers_label]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["karma_helpers_label": karma_helpers_label]
            ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[spread_label]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["spread_label": spread_label]
            ))
    }
}