//
//  Recipe.swift
//  RecipeListApp
//
//  Created by Brent on 31/1/2022.
//

import Foundation

class Recipe:Identifiable, Decodable {
    
    var id:UUID?
    var name:String
    var featured:Bool
    var image:String
    var description:String
    var prepTime:String
    var cookTime:String
    var totalTime:String
    var servings:Int
    var ingredients:[Indgredient]
    var highlights:[String]
    var directions:[String]
    // If you don't care about some of the data,
    // there's no need to create a property.
    
}

class Indgredient:Identifiable, Decodable {
    
    var id:UUID?
    var name:String
    var num:Int?
    var denom:Int?
    var unit:String?
    
}
