//
//  ViewController.swift
//  Date Formating
//
//  Created by Alex on 3/31/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        static let DefaultDateFormat = "MM/dd/yy"
        
    }
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var secondDateLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let timestamp = Date().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: time) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "EEEE, M/dd/yy h:mm a"
        // again convert your date to string
        let thisIsTime = formatter.string(from: yourDate!)
        
        let days = Calendar.current.dateComponents([.day], from: time, to: Date()).day    // 5971
        let weekday = Calendar.current.component(.weekday, from: time) - 1
        
        
        let calendar = Calendar.current
        if calendar.isDateInToday(time) {
            secondDateLbl.text = String(thisIsTime.suffix(8))
        } else if calendar.isDateInYesterday(time) {
            secondDateLbl.text = "Yesterday"
        } else if days! < 8 {
            formatter.dateFormat = "EEEE"
            secondDateLbl.text = formatter.string(from: yourDate!)
        } else {
            secondDateLbl.text = String(thisIsTime.prefix(8))
        }
        dateLbl.text = thisIsTime
        
        //Get current timezone
        let timeZone = TimeZone.current.identifier
        
        //Grab day of the week by name, ex: Monday
//        if days! < 7 {
//            formatter.dateFormat = "EEEE"
//            dateLbl.text = formatter.string(from: yourDate!)
//            print(weekday)
//        }
        
        //Moments ago.. can use
        dateLbl.text = time.getElapsedInterval()
    }
    
    // MARK: - Instance Variables
    private lazy var dateFormatter : DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = Constants.DefaultDateFormat
        return df
    }()
}

extension Date {
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"
        }
    }
}

