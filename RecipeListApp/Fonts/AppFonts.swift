//
//  AppFonts.swift
//  RecipeListApp
//
//  Created by Brent on 24/2/2022.
//

import SwiftUI

struct AppFonts {
    
    static private let fontName = "Lato"
    
    static var largeTitle = Font.custom("\(fontName) Black", size: 40.0)
    static var title = Font.custom("\(fontName) Black", size: 30.0)
    static var regular = Font.custom("\(fontName) Regular", size: 16.0)
    static var regularBold = Font.custom("\(fontName) Bold", size: 16.0)
    
    static func regularWithSize(_ size:Double) -> Font {
        Font.custom("\(fontName) Regular", size: size)
    }
    
}
