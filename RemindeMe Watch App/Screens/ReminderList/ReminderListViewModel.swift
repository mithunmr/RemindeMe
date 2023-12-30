//
//  ReminderListViewModel.swift
//  LearnWatch Watch App
//
//  Created by MRM on 19/12/23.
//

import Foundation

class ReminderListViewModel:ObservableObject {
    let notificationManager = NotificationManager()
    @Published var reminders:[ReminderModel] = []
    @Published var reminderDeleted:Bool = false
    @Published var showSheet:Bool = false
    func loadReminders(){
        CoreDataManager().fetchReminder{  [weak self](data,error) in
            guard let weakSelf = self ,(error == nil) else {return}
            weakSelf.reminders = data ?? []
        }
    }
    
    func deleteReminder(reminder:ReminderModel){
        CoreDataManager().deleteReminder(reminderData: reminder){ result in
            if result == true{
                self.notificationManager.deleteNotification(id: reminder.id.uuidString)
            }
            self.showSheet =  result
            
        }
    }
    
  
}
