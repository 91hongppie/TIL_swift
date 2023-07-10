//
//  ContentView.swift
//  Dicee-SwiftUI
//
//  Created by Kyuhong Jo on 2023/07/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("background")
            .resizable()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(n: 2)
                    DiceView(n: 2)
                }
                .padding(.horizontal)
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Roll")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .background(Color.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DiceView: View {
    
    let n: Int
    
    var body: some View {
        Image("dice\(n)").resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
}
