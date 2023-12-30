//
//  AddReminderViewModel.swift
//  LearnWatch Watch App
//
//  Created by MRM on 19/12/23.
//

import Foundation
class AddReminderViewModel:ObservableObject {
    let notificationManager = NotificationManager()
    @Published var remiderModel:ReminderModel = ReminderModel(title: "", type: .normal, note: "", dateTime: .init())
    @Published var showSheet:Bool = false
  
    var message:String = ""
    var inertType:InsertType = .addNew
    
    init(reminder:ReminderModel = ReminderModel(title: "", type: .normal, note: "", dateTime: .init()), insertionType:InsertType = .addNew) {
        remiderModel.id = reminder.id
        remiderModel.title = reminder.title
        remiderModel.type = reminder.type
        remiderModel.note = reminder.note
        remiderModel.dateTime = reminder.dateTime
        inertType = insertionType
        
    }
    
    func addReminder(){
        if validate(){
            let reminder = ReminderModel(title: remiderModel.title, type: remiderModel.type, note: remiderModel.note, dateTime: remiderModel.dateTime)
            CoreDataManager().insertReminder(reminderData: reminder){ result in
                
                if result == true {
                    self.notificationManager.addNotification(reminderData: reminder)
                    self.remiderModel = ReminderModel(title: "", type: .normal, note: "", dateTime: .init())
                }
                self.message = self.inertType == .addNew ? "Reminder Added Successfully" : "Reminder edited Successfully"
                self.showSheet = result
            }
        }else{
            self.message = "Plese enter title"
            self.showSheet = true
        }
    }
    
    func editReminder(){
        let reminder = ReminderModel(id:remiderModel.id, title: remiderModel.title, type: remiderModel.type, note: remiderModel.note, dateTime: remiderModel.dateTime)
        CoreDataManager().updateReminder(reminderData: reminder){ result in
            
            
            self.message = self.inertType == .addNew ? "Reminder Added Successfully" : "Reminder edited Successfully"
            self.showSheet = result
        }
    }
    
    
    func validate() ->Bool {
        !remiderModel.title.isEmpty
    }
    func resetRemiderModel(){
        self.remiderModel = ReminderModel(title: "", type: .normal, note: "", dateTime: .init())
    }

    
}
