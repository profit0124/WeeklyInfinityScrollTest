//
//  WeeklyCalendarTestApp.swift
//  WeeklyCalendarTest
//
//  Created by Sooik Kim on 2023/02/27.
//

import SwiftUI

@main
struct WeeklyCalendarTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
