//
//  ReminderDetails.swift
//  RemindeMe Watch App
//
//  Created by MRM on 28/12/23.
//

import SwiftUI

struct ReminderDetails: View {
    @StateObject var vm:ReminderDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            GeometryReader{ geometry in
                VStack(alignment:.leading) {
                    VStack(alignment:.leading) {
                        HStack(alignment: .bottom){
                            Text(vm.reminderData.title.capitalized)
                                .font(.title)
                            Image(vm.reminderData.reminderTypeImage)
                                .resizable()
                                .frame(width: 25,height: 25)
                                .padding(.bottom,5)
                        }.padding(.bottom,5)
                        Text(vm.reminderData.dateTime.stringDate)
                            .font(.system(size: 12))
                            .foregroundColor(.blue)
                    }
                    
                    ScrollView(){
                        Text(vm.reminderData.note.capitalized)
                            .font(.caption)
                            .foregroundColor(.accentColor)
                    }
                    .frame(width: geometry.size.width,alignment: .leading)
                    .overlay(alignment:.bottomTrailing){
                        VStack(alignment: .trailing,spacing: 5){
                            NavigationLink(destination: AddReminder(vm:AddReminderViewModel(reminder: vm.reminderData,insertionType: .edit),editComplition: updateData),label: {
                                Image(systemName: "pencil")
                            })
                            .background(.green)
                            .clipShape(Circle())
                            .frame(width: 30,height: 30)
                            Button{
                                vm.deleteReminder()
                            }label: {
                                Image(systemName: "trash")
                            }
                            .background(.red)
                            .clipShape(Circle())
                            .frame(width: 30,height: 30)
                        }
                        .frame(width: 30)
                        .padding(.trailing,15)
                        .padding(.bottom,25)
                    }
                    .sheet(isPresented: $vm.showSheet){
                        VStack {
                            Text(vm.message )
                                .multilineTextAlignment(.center)
                            Button{
                                vm.showSheet = false
                                presentationMode.wrappedValue.dismiss()
                            }label: {
                                Text("OK")
                            }
                        }
                    }
                }.ignoresSafeArea()
                .padding(.top)
            }
        }
    }
    func updateData(reminder:ReminderModel){
        
        vm.reminderData = reminder
        
    }
}

struct ReminderDetails_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetails(vm: .init(reminderData: ReminderModel(title: "Test", type: .food, note: "Tetsing", dateTime: .init())))
    }
}
