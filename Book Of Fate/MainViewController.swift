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
    var birthCardLabel : UILabel = UILabel()
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
        let grand_solar_spread = MICSpread.grand_solar_spread_for_years(age)
        calculateKarmaCards(birth_card, spread: grand_solar_spread)
        spread_label.text = grand_solar_spread.unicode_spread()
        labelBirthCard(birth_card)
    }
    
    func labelBirthCard(birth_card : MICCard) {
        birthCardLabel.text = "Your birth card: " + birth_card.description
    }
    
    func calculateKarmaCards(birth_card : MICCard, spread : MICSpread) {
        let first_karma_card = birth_card.karma_card_to_owe()
        karma_helpers_label.text = spread.karmic_helpers_text(first_karma_card)
    }
    
    func setupViewsAndConstraints() {
        view.backgroundColor = UIColor.whiteColor()
        
        datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.addTarget(self, action: #selector(dateUpdated), forControlEvents: UIControlEvents.ValueChanged)
        view.addSubview(datePicker)
        
        birthCardLabel = UILabel()
        birthCardLabel.translatesAutoresizingMaskIntoConstraints = false
        birthCardLabel.textAlignment = NSTextAlignment.Center
        birthCardLabel.text = "Card for Date"
        view.addSubview(birthCardLabel)
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
            views: ["outputLabel": birthCardLabel]
            ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[datePicker(==150)][outputLabel(==40)][spread_label(==200)][karma_helpers_label(==300)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["datePicker": datePicker, "outputLabel": birthCardLabel, "karma_helpers_label": karma_helpers_label, "spread_label": spread_label]
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