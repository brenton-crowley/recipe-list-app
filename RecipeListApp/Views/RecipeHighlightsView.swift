//
//  RecipeHighlightsView.swift
//  RecipeListApp
//
//  Created by Brent on 24/2/2022.
//

import SwiftUI

struct RecipeHighlightsView: View {
    
    var highlights:[String]?
    
    var body: some View {
        
        if let highlights = highlights {
            Text(highlights.joined(separator: ", "))
        } else {
            Text("It's awesome!")
        }
    }
}

struct RecipeHighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHighlightsView(highlights: ["One", "Two", "Three"])
    }
}
