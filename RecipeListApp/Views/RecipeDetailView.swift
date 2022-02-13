//
//  RecipeDetailView.swift
//  RecipeListApp
//
//  Created by Brent on 2/2/2022.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipe:Recipe
    
    var body: some View {
        ScrollView() {
            
                // MARK: Image
                Image(recipe.image)
                    . resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .frame(height: 200)
                    
                // MARK: Ingredients
                VStack (alignment: .leading) {
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 2)
                    ForEach(recipe.ingredients) { ingredient in
                        Text("• \(ingredient.name)")
                            .padding(.bottom, 1)
                    }
                    // MARK: Divider
                    Divider()
                    
                    // MARK: Directions
                    VStack (alignment: .leading) {
                        Text("Directions")
                            .font(.title2)
                            .bold()
                            .padding(.vertical, 2)
                        ForEach(recipe.directions.indices, id: \.self) { index in
                            
                            let direction = recipe.directions[index]
                            
                            HStack (alignment: .top) {
                                Text("Step \(index+1)").bold()
                                Text("\(direction)")
                                    .padding(.bottom, 1)
                            }
                        }
                    }
                }.padding()
            
            
        }
    }
}

struct RecipeDetailView_Previews:
    
    PreviewProvider {
    static var previews: some View {
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
