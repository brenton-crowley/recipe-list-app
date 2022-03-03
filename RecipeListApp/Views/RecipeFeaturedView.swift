//
//  RecipeFeaturedView.swift
//  RecipeListApp
//
//  Created by Brent on 14/2/2022.
//

import SwiftUI

struct RecipeFeaturedView: View {
        
//    @EnvironmentObject var recipeModel:RecipeModel
    @State var isDetailViewShowing = false
    @State var selectedTab:Int = 0
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],
                  predicate: NSPredicate(format: "featured == true")) var featuredRecipes:FetchedResults<Recipe>
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top, 25)
                .offset(y: 40)
                .font(AppFonts.title)
            
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
                                    let image = UIImage(data: recipe.image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(recipe.name)
                                        .padding(5)
                                        .font(AppFonts.regularBold)
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
                    .font(AppFonts.regularBold)
                Text(featuredRecipes[selectedTab].prepTime)
                    .font(AppFonts.regular)
                Text("Highlights: ")
                    .font(AppFonts.regularBold)
                
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
