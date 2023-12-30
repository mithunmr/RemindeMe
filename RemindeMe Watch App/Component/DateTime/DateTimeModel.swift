//
//  DateTimeModel.swift
//  RemindeMe Watch App
//
//  Created by MRM on 20/12/23.
//

import Foundation
struct DateTimeModel{
    var date:Int
    var month:Int
    var year:Int
    var hour:Int
    var minute:Int
    var ampm:String
    
    init(date:Int = Int(Date.now.getDay()) ?? 0,
         month:Int = Int(Date.now.getMoth()) ?? 0,
         year:Int = Int(Date.now.getYear()) ?? 0,
         hour:Int = Int(Date.now.getHour()) ?? 0,
         minute:Int = Int(Date.now.getMin()) ?? 0,
         ampm:String = "AM" ){
        self.date = date
        self.month = month
        self.year = year
        self.hour = hour
        self.minute = minute
        self.ampm = ampm
    }
}

extension DateTimeModel {
    var stringDate:String {
        "\(date)-\(month)-\(year) \(hour):\(minute):00 \(ampm)"
    }
    var getDateTime:Date{
        Date().getDateFormString(stringDate)
    }
}
