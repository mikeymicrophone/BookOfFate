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
        outputLabel.text = "\(birth_card.face) of \(birth_card.suit)"
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