//
//  UserExplorerProApp.swift
//  UserExplorerPro
//
//  Created by Kaushikkumar on 19/03/26.
//

import SwiftUI
import SwiftData

@main
struct UserExplorerProApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            UserListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
