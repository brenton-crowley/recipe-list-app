//
//  ContentView.swift
//  RecipeListApp
//
//  Created by Brent on 31/1/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var recipeModel:RecipeModel
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                Text("All Recipes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top,50)
                
                ScrollView {
                    LazyVStack (alignment: .leading) {
                        ForEach(recipeModel.recipes) { recipe in
                            
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                                    .navigationBarTitle(recipe.name)
                            } label: {
                                HStack(spacing: 20.0) {
                                    
                                    Image(recipe.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                        .cornerRadius(5
                                        )
                                    Text(recipe.name)
                                        .foregroundColor(.black)
                                    
                                }
                            }
                        }.navigationBarHidden(true)
                    }
                }
            }.padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RecipeModel())
    }
}
