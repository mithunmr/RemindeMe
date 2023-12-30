//
//  NotificationManager.swift
//  RemindeMe Watch App
//
//  Created by MRM on 28/12/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    let center = UNUserNotificationCenter.current()
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge, .provisional]) { granted, error in
            if let error = error {
                print("Permission not granted: \(error.localizedDescription)")
            }
        }
        center.getNotificationSettings { settings in
            guard (settings.authorizationStatus == .authorized) ||
                    (settings.authorizationStatus == .provisional) else { return }
        }
    }
    func addNotification(reminderData:ReminderModel){
        let content = UNMutableNotificationContent()
        content.title = reminderData.title
        content.subtitle = reminderData.note
        content.sound = .defaultCritical
        var date = DateComponents()
        date.day = reminderData.dateTime.date
        date.month = reminderData.dateTime.month
        date.year = reminderData.dateTime.year
        date.hour = reminderData.dateTime.ampm == "PM" ? reminderData.dateTime.hour+12:reminderData.dateTime.hour
        date.minute = reminderData.dateTime.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request =  UNNotificationRequest(identifier: reminderData.id.uuidString, content: content, trigger: trigger)
        center.add(request){ (error) in
            guard let error = error else {return}
            print(error.localizedDescription)
        }
    }
    
    func deleteNotification(id:String){
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
}

