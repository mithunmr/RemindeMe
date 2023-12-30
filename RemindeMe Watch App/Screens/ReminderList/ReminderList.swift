//
//  ReminderList.swift
//  LearnWatch Watch App
//
//  Created by MRM on 19/12/23.
//

import SwiftUI

struct ReminderList: View {
    @StateObject var vm = ReminderListViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(alignment: .leading,spacing: 10){
                    Text("Reminders")
                    if vm.reminders.isEmpty {
                        VStack(){
                            Text("No Reminders found")
                        }
                    }else{
                        List(vm.reminders,id:\.id){reminder in
                            NavigationLink(destination: ReminderDetails(vm: ReminderDetailsViewModel(reminderData:reminder))) {
                                HStack {
                                    Text(reminder.title)
                                        .swipeActions{
                                            Button() {
                                                vm.deleteReminder(reminder: reminder)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }.tint(.red)
                                    }
                                    Spacer()
                                    Image(reminder.reminderTypeImage)
                                        .resizable()
                                        .frame(width: 20,height: 20)
                                }
                            }
                        }.listStyle(.plain)
                    }
                }.padding(.top,geometry.safeAreaInsets.top)
                    .padding(.leading)
                    .ignoresSafeArea()
            }.onAppear{
                Task{
                    vm.loadReminders()
                }
            }
            .sheet(isPresented: $vm.reminderDeleted){
                VStack {
                    Text("Reminder Deleted Successfully")
                        .multilineTextAlignment(.center)
                    Button{
                        vm.reminderDeleted = false
                    
                    }label: {
                        Text("OK")
                    }
                }
            }
        }
    }
}

struct ReminderList_Previews: PreviewProvider {
    static var previews: some View {
        ReminderList()
    }
}
