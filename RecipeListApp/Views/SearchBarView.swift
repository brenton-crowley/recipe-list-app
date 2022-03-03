//
//  SearchBarView.swift
//  RecipeListApp
//
//  Created by Brent on 3/3/2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text:String
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(.white)
                .shadow(radius: 4.0)
            
            HStack {
                
                Image(systemName: "magnifyingglass")
                
                TextField("Filter by ...", text: $text)
                    .padding()
                
                Button {
                    // clear the text
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                }
                .buttonStyle(.plain)

            }
            .padding(.horizontal)
            
        }
        .frame(height: 50.0)
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SearchBarView(text: Binding.constant(""))
    }
}
