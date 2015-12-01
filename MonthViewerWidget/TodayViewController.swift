//
//  TodayViewController.swift
//  MonthViewerWidget
//
//  Created by Le Huu Tri on 11/3/15.
//  Copyright © 2015 Le Huu Tri. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {
    //being displayed
    var month = 0;
    var year = 0;
    
    //today
    var thisDay = 0;
    var thisMonth = 0;
    var thisYear = 0;
    
    let monthText = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    
    @IBOutlet var textView: NSTextView!
    @IBOutlet var pMonth: NSButton!
    @IBOutlet var nMonth: NSButton!
    @IBOutlet var lMonth: NSTextField!
    @IBOutlet var lYear: NSTextField!
    @IBOutlet var todayMonth: NSButton!
    
    func updateCal() {
        // navagation view
        lMonth.stringValue = monthText[month - 1]
        lYear.stringValue = String(year)
        if (month == thisMonth && year == thisYear) {
            todayMonth.enabled = false
        } else {
            todayMonth.enabled = true
        }
        
        //calendar view
        let cal = MonthCal(m: month, y: year)
        textView.string = cal.to_text()

        //highlight today
        if (month == thisMonth && year == thisYear) {
            let myMutableString = NSMutableAttributedString(attributedString: textView.attributedString())
            let todayCol = cal.day + (cal.dow - 1) - 1
            let todayLocation = todayCol * 3 + Int(todayCol/7)
            myMutableString.addAttribute(NSForegroundColorAttributeName,
                value: NSColor.greenColor(),
                range: NSRange(location:todayLocation, length:2))
            textView.textStorage?.setAttributedString(myMutableString)
        }
    }
    
    func setToday() {
        let cal = MonthCal()
        month = cal.month
        year = cal.year

        thisDay = cal.day
        thisMonth = month
        thisYear = year
    }

    @IBAction func goToday(sender: AnyObject) {
        setToday()
        updateCal()
    }

    @IBAction func goPreviousMonth(sender: AnyObject) {
        month--
        if month == 0 {
            month = 12
            year--
        }

        updateCal()
    }

    @IBAction func goNextMonth(sender: AnyObject) {
        month++
        if month == 13 {
            month = 1
            year++
        }
        
        updateCal()
    }
    
    @IBAction func goPreviousYear(sender: AnyObject) {
        year--
        if year == 0 {
            year = 1
        }

        updateCal()
    }
    
    @IBAction func goNextYear(sender: AnyObject) {
        year++
        if year == 10000 {
            year = 9999
        }
        
        updateCal()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setToday()
        updateCal()
    }

    override var nibName: String? {
        return "TodayViewController"
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        completionHandler(.NoData)
    }
    
}
