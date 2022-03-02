//
//  ContentView.swift
//  RecipeListApp
//
//  Created by Brent on 31/1/2022.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var recipeModel:RecipeModel
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                Text("All Recipes")
                    .font(AppFonts.largeTitle)
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
            }.padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RecipeModel())
    }
}
