//
//  probablyareminderApp.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 22/02/23.
//

import SwiftUI

@main
struct probablyareminderApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
