//
//  RecipeFeaturedView.swift
//  RecipeListApp
//
//  Created by Brent on 14/2/2022.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var recipeModel:RecipeModel
    @State var isDetailViewShowing = false
    @State var selectedTab:Int = 0
    
    var featuredRecipes:[Recipe] { recipeModel.recipes.filter({ $0.featured == true}) }
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top, 25)
                .offset(y: 40)
            
            GeometryReader { geo in
                TabView(selection: $selectedTab) {
                    
                    ForEach(featuredRecipes.indices) { index in
                        
                        let recipe = featuredRecipes[index]
                        
                        Button {
                            // Show the recipe detail sheet.
                            self.isDetailViewShowing = true
                            self.selectedTab = index
                        } label: {
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
                            }
                        }
                        .tag(index)
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: geo.size.width - 40, height: geo.size.height - 100)
                        .cornerRadius(15)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10, x: -5, y: 5)
                        .sheet(isPresented: $isDetailViewShowing) {
                            RecipeDetailView(recipe: recipe)
                        }


                        
                        
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
            }
            
            VStack (alignment: .leading, spacing: 5) {
                
                
                
                Text("Prepration Time: ")
                    .font(.headline)
                Text(featuredRecipes[selectedTab].prepTime)
                Text("Highlights: ")
                    .font(.headline)
                
                RecipeHighlightsView(highlights: featuredRecipes[selectedTab].highlights)
                
            }.padding([.leading, .bottom])
        }
        
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView().environmentObject(RecipeModel())
    }
}
