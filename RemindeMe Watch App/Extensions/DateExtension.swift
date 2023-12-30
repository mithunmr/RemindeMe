//
//  DateExtension.swift
//  RemindeMe Watch App
//
//  Created by MRM on 26/12/23.
//

import Foundation


extension Date {
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    func getMoth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from: self)
    }
    
    func getYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.string(from:self)
    }
    
    func getHour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        dateFormatter.dateFormat = "h"
        
        return dateFormatter.string(from:self)
    }
    
    func getMin() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "mm"
        
        return dateFormatter.string(from: self)
    }
    
    func getAMPM() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "a"
        
        return dateFormatter.string(from: self)
    }
    
    func getDateFormString(_ stringDate:String) ->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss a"

        return dateFormatter.date(from: stringDate) ?? .now
    }
    
    
    func  getDateTimeModel() ->DateTimeModel {
        return DateTimeModel(date:Int(self.getDay()) ?? 0,
                             month:Int(self.getMoth()) ?? 0,
                             year:Int(self.getYear()) ?? 0,
                             hour:Int(self.getHour()) ?? 0,
                             minute:Int(self.getMin()) ?? 0,
                             ampm:self.getAMPM())
        
        
    }
    
    
}



