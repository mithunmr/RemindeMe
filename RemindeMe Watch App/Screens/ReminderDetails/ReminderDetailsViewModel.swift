//
//  ReminderDetailsViewModel.swift
//  RemindeMe Watch App
//
//  Created by MRM on 28/12/23.
//

import Foundation

class ReminderDetailsViewModel:ObservableObject {
    let notificationManager = NotificationManager()
    @Published var reminderData:ReminderModel
    @Published var showSheet:Bool = false
    var message:String = ""
    init(reminderData: ReminderModel) {
        self.reminderData = reminderData
    }
    
    
    func deleteReminder(){
        CoreDataManager().deleteReminder(reminderData: reminderData){ result in
            if result == true{
                self.notificationManager.deleteNotification(id: self.reminderData.id.uuidString)
                self.message = "Reminder Deleted Successfully"
            }else{
                self.message = "Reminder Deletion Failed"
            }
            self.showSheet =  result
        }
    }
}
