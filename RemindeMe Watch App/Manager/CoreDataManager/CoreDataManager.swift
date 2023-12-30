//
//  CoreDataManager.swift
//  LearnWatch Watch App
//
//  Created by MRM on 19/12/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared = CoreDataManager()
    let reminderContainer:NSPersistentContainer
    public init() {
        reminderContainer = NSPersistentContainer(name: "ReminderContainer")
        reminderContainer.loadPersistentStores{ (description,error) in
            if let error = error {
                print("Failed to load ReminderContainer : \(error.localizedDescription)")
            }
        }
    }
    
    func fetchReminder(complition:@escaping ([ReminderModel]?,Error?)->Void){
        let request = NSFetchRequest<ReminderEntity>(entityName: "ReminderEntity")
        do {
            let data = try reminderContainer.viewContext.fetch(request).map({
               return ReminderModel(id: $0.id ?? UUID(), title: $0.title ?? "", type: ReminderType(rawValue: $0.type ?? "" ) ?? .normal, note: $0.note ?? "", dateTime: $0.dateTime?.getDateTimeModel() ?? .init())
                
            })
          
            complition(data, nil)
        } catch {
            complition(nil,error)
            print("Failed to fetch Remoinder : \(error.localizedDescription)")
        }
    }
    
    func getReminder(id:UUID,completion:@escaping (ReminderModel?,Error?)->Void) {
        let fetchRequest: NSFetchRequest<ReminderEntity> = ReminderEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let thereminder = try reminderContainer.viewContext.fetch(fetchRequest).first
            guard let reminder = thereminder else {
                print("Reminder with ID \(id) not found.")
                completion(nil,.some(ErrorUserInfoKey(rawValue: "Failed to fetch Reminder") as! Error))
                return
            }
            let reminderModel = ReminderModel(id:reminder.id ?? UUID(),
                                              title: reminder.title ?? "",
                                              type: ReminderType(rawValue: reminder.type ?? "") ?? .normal,
                                              note: reminder.note ?? "",
                                              dateTime: reminder.dateTime?.getDateTimeModel() ?? .init())
            completion(reminderModel,nil)
        } catch {
            print("Error fetching reminder: \(error.localizedDescription)")
            completion(nil,error)
        }
    }
    
    func insertReminder(reminderData:ReminderModel,complition:@escaping (Bool) -> Void){
        let reminder = ReminderEntity(context:reminderContainer.viewContext)
        reminder.id = reminderData.id
        reminder.title = reminderData.title
        reminder.type = reminderData.type.rawValue
        reminder.note = reminderData.note
        reminder.dateTime = reminderData.dateTime.getDateTime
        
        print(reminderData.dateTime,reminderData.dateTime.getDateTime)
        save(){ result in
            complition(result)
        }
    }
    
    
    func updateReminder(reminderData: ReminderModel, completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<ReminderEntity> = ReminderEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", reminderData.id as CVarArg)

        do {
            let existingReminder = try reminderContainer.viewContext.fetch(fetchRequest).first
            guard let reminder = existingReminder else {
                print("Reminder with ID \(reminderData.id) not found.")
                completion(false)
                return
            }
            reminder.title = reminderData.title
            reminder.type = reminderData.type.rawValue
            reminder.note = reminderData.note
            save { result in
                completion(result)
            }
        } catch {
            print("Error fetching reminder: \(error.localizedDescription)")
            completion(false)
        }
    }

    
    func deleteReminder(reminderData: ReminderModel, completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<ReminderEntity> = ReminderEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@",reminderData.id as CVarArg)

        do {
 
            if let reminder = try reminderContainer.viewContext.fetch(fetchRequest).first {
                reminderContainer.viewContext.delete(reminder)
                save { result in
                    completion(result)
                }
            } else {
                print("Reminder not found")
                completion(false)
            }
        } catch {
            print("Error deleting reminder: \(error.localizedDescription)")
            completion(false)
        }
    }

    func save(complition:@escaping(Bool)->Void){
        do {
            try reminderContainer.viewContext.save()
            complition(true)
        }catch {
            reminderContainer.viewContext.rollback()
            print("Operation Failed on Reminder \(error.localizedDescription)")
            complition(false)
        }
    }
}
