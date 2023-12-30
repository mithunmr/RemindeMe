//
//  LearnWatchApp.swift
//  LearnWatch Watch App
//
//  Created by MRM on 18/12/23.
//

import SwiftUI

@main
struct RemindeMe: App {
    let notificationManager = NotificationManager()
    init(){
        notificationManager.requestPermission()
    }
    var body: some Scene {
        WindowGroup {
            Home()
        }
    }
}
