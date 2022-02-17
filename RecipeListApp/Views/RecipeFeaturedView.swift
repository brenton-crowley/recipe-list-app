//
//  RecipeFeaturedView.swift
//  RecipeListApp
//
//  Created by Brent on 14/2/2022.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var recipeModel:RecipeModel
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top,50)
            
            GeometryReader { geo in
                TabView {
                    
                    let featuredRecipes = recipeModel.recipes.filter({ $0.featured == true})
                    
                    ForEach(featuredRecipes) { recipe in
                        
                        ZStack {
                            // Recipe Card
                            Rectangle()
                                .foregroundColor(.white)
                            
                            VStack (spacing: 0) {
                                Image(recipe.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                Text(recipe.name)
                                    .padding(5)
                            }
                        }.frame(width: geo.size.width - 40, height: geo.size.height - 100)
                            .cornerRadius(15)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10, x: -5, y: 5)
                    }
                    
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
            }.padding(.bottom, 20)
            
            VStack (alignment: .leading, spacing: 5) {
                Text("Prepration Time: ")
                    .font(.headline)
                Text("Prepration 1 Hour: ")
                Text("Highlights: ")
                    .font(.headline)
                Text("Healthy, Hearty: ")
            }.padding([.leading, .bottom])
        }
        
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView().environmentObject(RecipeModel())
    }
}
