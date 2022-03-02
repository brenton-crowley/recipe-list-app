//
//  RecipeListAppApp.swift
//  RecipeListApp
//
//  Created by Brent on 31/1/2022.
//

import SwiftUI

@main
struct RecipeListApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RecipeTabView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
