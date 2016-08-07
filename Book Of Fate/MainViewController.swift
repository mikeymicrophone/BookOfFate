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
    var longRangeCardLabel : UILabel = UILabel()
    var planetaryCardLabel : UILabel = UILabel()
    var plutoCardLabel : UILabel = UILabel()
    var resultCardLabel : UILabel = UILabel()
    var datePicker : UIDatePicker = UIDatePicker()
    var karma_helpers_label = UILabel()
    var karma_helpees_label = UILabel()
    var spread_label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewsAndConstraints()
    }
    
    func dateUpdated() {
        let person = MICPerson(birth_date: datePicker.date)
        let month = NSCalendar.currentCalendar().component(.Month, fromDate: datePicker.date)
        let day = NSCalendar.currentCalendar().component(.Day, fromDate: datePicker.date)
        let seconds : NSTimeInterval = datePicker.date.timeIntervalSinceNow
        let age = Int(seconds / (-60*60*24*365.25) + 1)
        let birth_card = MICCard.birthCardForMonth(month, day: day)
        birth_card.age = age
        let grand_solar_spread = MICSpread.grand_solar_spread_for_years(age)
        calculateKarmaCards(birth_card, spread: grand_solar_spread)
        spread_label.text = grand_solar_spread.unicode_spread()
        labelBirthCard(birth_card)
        labelPlanetaryCard(birth_card, spread: grand_solar_spread, month: month, day: day)
        labelPlutoCard(birth_card)
        labelResultCard(birth_card)
        labelLongRangeCard(person)
        print(NSDate().card_for_hour())
    }
    
    func labelBirthCard(birth_card : MICCard) {
        birthCardLabel.text = "   Birth card: " + birth_card.description
    }
    
    func labelLongRangeCard(person : MICPerson) {
        longRangeCardLabel.text = "   This year: " + person.long_range_card().description
    }
    
    func labelPlanetaryCard(birth_card : MICCard, spread : MICSpread, month : Int, day : Int) {
        let planet = spread.planet_for_card(birth_card, month: month, day: day)
        let planetary_card = spread.planetary_card_for_card(birth_card, month: month, day: day)
        planetaryCardLabel.text = "   Planetary card: " + planetary_card.description + " (\(planet))"
    }
    
    func labelPlutoCard(birth_card : MICCard) {
        plutoCardLabel.text = "   Pluto card: " + birth_card.pluto_card_for_age(birth_card.age!).description
    }
    
    func labelResultCard(birth_card : MICCard) {
        resultCardLabel.text = "   Result card: " + birth_card.result_card_for_age(birth_card.age!).description
    }
    
    func calculateKarmaCards(birth_card : MICCard, spread : MICSpread) {
        let first_karma_card = birth_card.karma_card_to_owe()
        let second_karma_card = birth_card.karma_card_owed()
        karma_helpers_label.text = spread.karmic_helpers_text(second_karma_card, title: "Your helpers are") + "\n" + spread.karmic_helpers_text(first_karma_card, title: "You help")
    }
    
    func setupViewsAndConstraints() {
        view.backgroundColor = UIColor.whiteColor()
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.addTarget(self, action: #selector(dateUpdated), forControlEvents: UIControlEvents.ValueChanged)
        view.addSubview(datePicker)

        birthCardLabel.translatesAutoresizingMaskIntoConstraints = false
        birthCardLabel.text = "       Select your birthdate (or your friend's)."
        view.addSubview(birthCardLabel)
        
        longRangeCardLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(longRangeCardLabel)
        
        planetaryCardLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(planetaryCardLabel)
        
        plutoCardLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plutoCardLabel)
        
        resultCardLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultCardLabel)

        karma_helpers_label.translatesAutoresizingMaskIntoConstraints = false
        karma_helpers_label.textAlignment = .Center
        karma_helpers_label.numberOfLines = 12
        view.addSubview(karma_helpers_label)
        
        spread_label.translatesAutoresizingMaskIntoConstraints = false
        spread_label.textAlignment = .Center
        spread_label.numberOfLines = 12
        spread_label.font = UIFont(name: "DejaVuSans", size: 23)
        view.addSubview(spread_label)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[datePicker]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["datePicker": datePicker]
        ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[birthCardLabel]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["birthCardLabel": birthCardLabel]
        ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[longRangeCardLabel]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["longRangeCardLabel": longRangeCardLabel]
        ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[planetaryCardLabel]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["planetaryCardLabel": planetaryCardLabel]
        ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[plutoCardLabel]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["plutoCardLabel": plutoCardLabel]
        ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[resultCardLabel]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["resultCardLabel": resultCardLabel]
        ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[datePicker(==150)][birthCardLabel(==25)][longRangeCardLabel(==25)][planetaryCardLabel(==25)][plutoCardLabel(==25)][resultCardLabel(==25)][spread_label(==250)][karma_helpers_label(==100)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: ["datePicker": datePicker, "birthCardLabel": birthCardLabel, "karma_helpers_label": karma_helpers_label, "spread_label": spread_label, "plutoCardLabel": plutoCardLabel, "resultCardLabel": resultCardLabel, "planetaryCardLabel": planetaryCardLabel, "longRangeCardLabel": longRangeCardLabel]
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