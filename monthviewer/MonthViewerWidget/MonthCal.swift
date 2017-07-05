//
//  MonthCal.swift
//  MonthViewerWidget
//
//  Created by Le Huu Tri on 11/4/15.
//  Copyright © 2015 Le Huu Tri. All rights reserved.
//

import Foundation

class MonthCal {
    let today = NSDate()
    let calendar = NSCalendar.currentCalendar()
    
    var day = 0
    var month = 0
    var year = 0
    var dow = 0
    var num_days = 0
    
    var month_title: String {
        get {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter.stringFromDate(today).uppercaseString
        }
    }
    
    var dow_header = "Su Mo Tu We Th Fr Sa"
    
    init(m:Int? = nil, y:Int? = nil) {
        var components = calendar.components([.Year, .Month, .Day], fromDate: today)
        day = components.day
        if let um = m {
            month = um
        } else {
            month = components.month
        }
        if let uy = y {
            year = uy
        } else {
            year = components.year
        }

        components.year = year
        components.month = month
        components.day = 1
        let firstday = calendar.dateFromComponents(components)
        components = calendar.components([.Weekday], fromDate: firstday!)
        dow = components.weekday
        
        num_days = calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate:firstday!).length
    }
    
    func to_text() -> String {
        var content = ""
        
        let col_len = 3;
        let front_padding = String(count: col_len * (dow - 1), repeatedValue: Character(" "))
        content += front_padding
        
        for d in 1...num_days {
            let s = String(format: "%2d ", d)
            content += s
            if (dow + d - 1) % 7 == 0 {
                content += "\n"
            }
        }
        
        let back_padding = String(count: col_len * (35 - num_days) - 1, repeatedValue: Character(" "))
        content += back_padding
        content += "\n"
        
        return content
    }
}