//
//  InfoView.swift
//  AngelaCard
//
//  Created by Kyuhong Jo on 2023/07/10.
//

import SwiftUI

struct InfoView: View {
    
    let text: String
    let imageName: String
    
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.white)
            .frame(height: 50)
            .overlay(
                HStack {
                    Image(systemName: imageName).foregroundColor(.green)
                    Text(text)
                        .foregroundColor(Color("Info Color"))

                }
                
            )
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Hello", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
