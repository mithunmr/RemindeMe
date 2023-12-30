//
//  AddReminder.swift
//  LearnWatch Watch App
//
//  Created by MRM on 19/12/23.
//

import SwiftUI

enum ReminderType:String,CaseIterable {
    case normal = "Normal"
    case food = "Food"
    case medicine = "Medicine"
    case work = "Work"
    
}
enum InsertType {
    case addNew
    case edit
}

struct AddReminder: View {
    @ObservedObject var vm:AddReminderViewModel
    @Environment(\.presentationMode) var presentationMode
    var editCompletion:((ReminderModel)->Void)?
 
    init(vm: AddReminderViewModel = AddReminderViewModel(insertionType: .addNew),editComplition:((ReminderModel)->Void)? = nil){
        self.vm = vm
        self.editCompletion = editComplition
        
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment:.leading){
                        Section("Title") {
                            TextField("Enter here", text: $vm.remiderModel.title)
                            .autocorrectionDisabled(true)
                        }.padding(.bottom)
                        
                        Section("Type") {
                            Picker(selection: $vm.remiderModel.type,label: EmptyView()){
                                ForEach(ReminderType.allCases,id: \.self){ type in
                                    Text(type.rawValue)
                                }
                            }
                            .pickerStyle(.navigationLink)
                        }.padding(.bottom)
                        
                        Section("Note"){
                            TextField("Note",text: $vm.remiderModel.note)
                                .autocorrectionDisabled(true)
                        }
                        .padding(.bottom)
                        
                        Section("Time"){
                            NavigationLink(destination: DateTime(submitDateTime: getDateTime), label: {
                                HStack {
                                    Text(vm.remiderModel.dateTime.stringDate)
                                        .font(.system(size:12))
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                }
                            })
                        }
                        .padding(.bottom)
                      
                        Button{
                            switch vm.inertType {
                            case .addNew:
                                vm.addReminder()
                            case .edit:
                                vm.editReminder()
                            }
                          
                        }label: {
                            Text(vm.inertType == .addNew ? "Add reminder" : "Edit reminder")
                        }.background(.green)
                            .clipShape(Capsule())
                    }
                    .padding()
                .padding(.top)
                }.sheet(isPresented: $vm.showSheet){
                    VStack {
                        Text(vm.message )
                            .multilineTextAlignment(.center)
                        Button{
                            vm.showSheet = false
                            if vm.inertType == .edit{
                                editCompletion?(vm.remiderModel)
                                vm.resetRemiderModel()
                            }
                            presentationMode.wrappedValue.dismiss()
                        
                        }label: {
                            Text("OK")
                        }
                    }
                }
            }
        }
    }
    
    func getDateTime(dateTimeData:DateTimeModel){
        vm.remiderModel.dateTime = dateTimeData
    }
}


struct AddReminder_Previews: PreviewProvider {
    static var previews: some View {
        AddReminder()
    }
}
