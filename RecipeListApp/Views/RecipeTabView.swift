//
//  RecipeTabView.swift
//  RecipeListApp
//
//  Created by Brent on 8/2/2022.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        TabView {
            
            Text("Featured View").tabItem {
                VStack {
                    Image(systemName: "star.fill")
                    Text("Featured")
                }
            }
            
            ContentView().tabItem {
                VStack {
                    Image(systemName: "list.bullet")
                    Text("Recipes")
                }
            }
        }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
