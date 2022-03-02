//
//  DataService.swift
//  Recipe List App
//
//  Created by Brent on 31/1/2022.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        
        // Parse Local json file
        
        return [Recipe]()
        
        //return getJSONDataObjectForResourceName("recipes", for: [RecipeJSON].self)
        
//        guard let pathString = Bundle.main.path(forResource: "recipes", ofType: "json") else {
//
//            return [Recipe]()
//        }
//
//        let url = URL(fileURLWithPath: pathString)
//
//        // create a data object
//        do {
//            // get a url path to the json file
//            let data = try Data(contentsOf: url)
//
//            // Decode the data with a json decoder
//            let decoder = JSONDecoder()
//
//            do {
//                let recipeData = try decoder.decode([Recipe].self, from: data)
//
//                // add the new unique ids
//
//                for recipe in recipeData {
//                    recipe.id = UUID()
//
//                    for ingredient in recipe.ingredients {
//                        ingredient.id = UUID()
//                    }
//                }
//
//                return recipeData
//
//            } catch {
//                print(error)
//            }
//
//        } catch  {
//            print(error)
//        }
//
//
//
//        // return the recipes.
//        return [Recipe]()
        
    }
        
    // perhaps use an extension, generic param and come back to this.
    static func getJSONDataObjectForResourceName<T>(_ resourceName:String, for modelType:T.Type) -> [T] where T : Decodable {


            guard let pathString = Bundle.main.path(forResource: resourceName, ofType: "json") else {

                return [T]()
            }

            let url = URL(fileURLWithPath: pathString)

            // create a data object
            do {
                // get a url path to the json file
                let data = try Data(contentsOf: url)

                // Decode the data with a json decoder
                let decoder = JSONDecoder()

                do {
                    let json = try decoder.decode([T].self, from: data)

                    // add the new unique ids

//                    for recipe in recipeData {
//                        recipe.id = UUID()
//                    }

                    return json

                } catch {
                    print(error)
                }

            } catch  {
                print(error)
            }

            return [T]()

        }
}

