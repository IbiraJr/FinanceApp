//
//  FinanceAppApp.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import SwiftUI

@main
struct FinanceAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
