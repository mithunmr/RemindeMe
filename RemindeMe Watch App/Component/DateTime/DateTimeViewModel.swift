//
//  DateTimeViewModel.swift
//  RemindeMe Watch App
//
//  Created by MRM on 20/12/23.
//

import Foundation
class DateTimeViewModel:ObservableObject {
    @Published var dateTime:DateTimeModel
    init() {
        let date = Date.now
        dateTime = DateTimeModel(date: Int(date.getDay()) ?? 0,
                                 month: Int(date.getMoth()) ?? 0,
                                 year: Int(date.getYear()) ?? 0,
                                 hour: Int( date.getHour()) ?? 0,
                                 minute: Int(date.getMin()) ?? 0,
                                 ampm:  date.getAMPM())
    }
}
