//
//  RecipeModel.swift
//  RecipeListApp
//
//  Created by Brent on 31/1/2022.
//

import SwiftUI

class RecipeModel:ObservableObject {
    
    //    @Published var recipes = [Recipe]()
    @FetchRequest(sortDescriptors: []) var recipes:FetchedResults<Recipe>
    let viewContext = PersistenceController.shared.container.viewContext
    
    init() {
        
      
        
        // Check if we have preloaded the data to core data
        checkLoadedData()
        
        
    }
    
    func checkLoadedData() {
        
        // Check local storage for a flag
        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreloaded)
                
        // If false, parse local json and load into coredata
        if !status {
            preloadLocalData()
        }
        
        
    }
    
    func preloadLocalData() {
        
        // Parse the local json file
        let localRecipes = DataService.getLocalData()
        
        // create core data objects
        for r in localRecipes {
            
            let recipe = Recipe(context: viewContext)
            recipe.id = UUID()
            recipe.name = r.name
            recipe.cookTime = r.cookTime
            recipe.directions = r.directions
            recipe.featured = r.featured
            recipe.image = UIImage(named: r.image)?.pngData()
            recipe.name = r.name
            recipe.prepTime = r.prepTime
            recipe.servings = r.servings
            recipe.summary = r.description
            recipe.totalTime = r.totalTime
            recipe.highlights = r.highlights
            
            for ingredient in r.ingredients {
                
                let i = Ingredient(context: viewContext)
                
                i.id = UUID()
                i.denom = ingredient.denom ?? 1
                i.name = ingredient.name
                i.num = ingredient.num ?? 1
                i.unit = ingredient.unit
                
                recipe.addToIngredients(i)
                
            }
            
        }
        
        
        // save into core data
        do {
            try viewContext.save()

            // set local storage flag
            UserDefaults.standard.setValue(true, forKey: Constants.isDataPreloaded)
        } catch {
            print(error)
        }

    }
    
    static func calculatedServingSizeForIngredient(_ ingredient:Ingredient, forRecipeServings recipeServings:Int, selectedServing targetServings:Int) -> String {
        
        //        if let num = ingredient.num,
        //           let denom = ingredient.denom {
        //
        //            let singleServing = denom * recipeServings
        //            let recipeServings = num * targetServings
        //
        //            let formula = recipeServings / singleServing
        //
        //
        //        }
        var portion = ""
        var numerator = ingredient.num
        var denominator = ingredient.denom
        var wholePortions = 0
        
        
        
        // Get a single serving size by multiplying denominator by the recipe servings
        denominator *= recipeServings
        
        // Get target portion by multiplying numerator by target servings
        numerator *= targetServings
        
        // Reduce fraction by greatest common divisor
        let divisor = Rational.greatestCommonDivisor(numerator, denominator)
        numerator /= divisor
        denominator /= divisor
        
        // Get the whole portion if numerator > denominator
        if numerator >= denominator {
            
            // Calculated whole portions
            wholePortions = numerator / denominator
            
            // Calculate the remainder
            numerator = numerator % denominator
            
            // Assign to portion string
            portion += String(wholePortions)
        }
        
        // Express the remainder as a fraction
        if numerator > 0 {
            
            // Assign remainder as fraction to the portion string
            portion += wholePortions > 0 ? " " : ""
            portion += "\(numerator)/\(denominator)"
        }
        
        
        
        if var unit = ingredient.unit {
            
            // If we need to pluralize
            if wholePortions > 1 {
                
                // Calculate appropriate suffix
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else {
                    unit += "s"
                }
            }
            
            portion += ingredient.num == 0 && ingredient.denom == 0 ? "" : " "
            
            return portion + unit
        }
        
        return portion
        
    }
    
}
