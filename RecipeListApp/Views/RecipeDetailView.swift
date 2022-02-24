//
//  RecipeDetailView.swift
//  RecipeListApp
//
//  Created by Brent on 2/2/2022.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipe:Recipe
    let servingSizes = [2, 4, 6, 8]
     
    @State var serving = 2
    
    var body: some View {
        ScrollView() {
            VStack (alignment:.leading) {
                // MARK: Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                // MARK: Recipe Name
                Text(recipe.name)
                    .font(AppFonts.title)
                    .fontWeight(.bold)
                    .padding([.horizontal, .bottom])
                
                // MARK: Serving Size
                
                VStack (alignment: .leading) {
                    Text("Choose your serving size")
                        .font(AppFonts.regularWithSize(13.0))
                    Picker("Choose your serving size", selection: $serving) {
                        ForEach(servingSizes, id: \.self) { size in
                            Text("\(size)").tag(size)
                                .font(AppFonts.regular)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                }.padding(.horizontal)
                
                // MARK: Ingredients
                VStack (alignment: .leading) {
                    Text("Ingredients")
                        .font(AppFonts.title)
                        .bold()
                        .padding(.vertical, 2)
                    ForEach(recipe.ingredients) { ingredient in
                        
                        let portion = RecipeModel.calculatedServingSizeForIngredient(
                            ingredient,
                            forRecipeServings: recipe.servings,
                            selectedServing: serving)
                        
                        Text("• \(portion) \(ingredient.name.lowercased())")
                            .padding(.bottom, 1)
                            .font(AppFonts.regular)
                    }
                    // MARK: Divider
                    Divider()
                    
                    // MARK: Directions
                    VStack (alignment: .leading) {
                        Text("Directions")
                            .font(AppFonts.title)
                            .bold()
                            .padding(.vertical, 2)
                        ForEach(recipe.directions.indices, id: \.self) { index in
                            
                            let direction = recipe.directions[index]
                            
                            HStack (alignment: .top) {
                                Text("Step \(index+1)")
                                    .font(AppFonts.regularBold)
                                Text("\(direction)")
                                    .padding(.bottom, 1)
                                    .font(AppFonts.regular)
                            }
                        }
                    }
                }.padding()
            }
            
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
