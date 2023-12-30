//
//  ReminderModel.swift
//  LearnWatch Watch App
//
//  Created by MRM on 19/12/23.
//

import Foundation
struct ReminderModel{
    var id:UUID = UUID()
    var title:String
    var type:ReminderType
    var note:String
    var dateTime:DateTimeModel
}

extension ReminderModel {
    var reminderTypeImage:String{
        switch type {
        case .normal:
            return ""
        case .food:
            return "food"
        case .medicine:
            return "medicine"
        case .work:
            return "work"
        }
    }
}




