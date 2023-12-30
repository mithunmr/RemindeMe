//
//  Home.swift
//  LearnWatch Watch App
//
//  Created by MRM on 19/12/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack {
            GeometryReader{ geometry in
                VStack(spacing:10){
                    NavigationLink(destination: AddReminder()){
                        Label("Add Reminder", systemImage: "note.text.badge.plus")
                            .bold()
                            .frame(maxHeight: geometry.size.height / 2)
                    }
                    NavigationLink(destination: ReminderList()){
                        Label("Reminder List ", systemImage: "list.bullet.rectangle.fill")
                            .bold()
                        .frame(maxHeight: geometry.size.height / 2)                    }
                }
            }
            .ignoresSafeArea()
            .padding()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
