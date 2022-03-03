//
//  ContentView.swift
//  RecipeListApp
//
//  Created by Brent on 31/1/2022.
//

import SwiftUI

struct ContentView: View {
    
//    @EnvironmentObject var recipeModel:RecipeModel
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) private var recipes:FetchedResults<Recipe>
    @State private var filterBy = ""
    @FocusState private var searchIsFocused:Bool
    
    private var filteredRecipes:[Recipe] {
        
        if filterBy.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            // No filtered text so return all
            return Array(recipes)
        } else {
            // Filter by the new search term
            return recipes.filter( {$0.name.contains(filterBy)} )
        }
        
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                Text("All Recipes")
                    .font(AppFonts.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top,50)
                
                SearchBarView(text: $filterBy)
                    .padding(.bottom)
                    .focused($searchIsFocused)
                    .onTapGesture {
                        searchIsFocused = true
                    }
                
                ScrollView {
                    LazyVStack (alignment: .leading) {
                        ForEach(filteredRecipes) { recipe in
                            
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                                    .navigationBarTitle(recipe.name)
                            } label: {
                                HStack(spacing: 20.0) {
                                    let image = UIImage(data: recipe.image ?? Data()) ?? UIImage() 
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                        .cornerRadius(5
                                        )
                                    VStack (alignment: .leading, spacing: 5) {
                                        Text(recipe.name)
                                            .foregroundColor(.black)
                                            .font(AppFonts.regular)
                                        RecipeHighlightsView(highlights: recipe.highlights)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    
                                }
                            }
                        }.navigationBarHidden(true)
                    }
                }
            }
            .padding()
            .onTapGesture {
                searchIsFocused = false
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RecipeModel())
    }
}
