//
//  RecipeModel.swift
//  RecipeListApp
//
//  Created by Brent on 31/1/2022.
//

import SwiftUI

class RecipeModel:ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        self.recipes = DataService.getLocalData()
        
    }
    
}
