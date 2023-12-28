//
//  GroceriesApp.swift
//  Groceries
//
//  Created by Kane Sweet on 12/28/23.
//

import SwiftUI

@main
struct GroceriesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .navigationTitle("Groceries")
        }
    }
}
