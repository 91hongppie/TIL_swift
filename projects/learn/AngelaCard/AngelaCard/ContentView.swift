//
//  ContentView.swift
//  AngelaCard
//
//  Created by Kyuhong Jo on 2023/07/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.09, green: 0.63, blue: 0.52)
            .edgesIgnoringSafeArea(.all)
            VStack {
                Image("spiderman").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 250)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Circle().stroke(Color.white, lineWidth:  5)
                    )

                Text("Kyuhong Jo")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                .foregroundColor(.white)
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                Divider()
                InfoView(text: "+82 010 8933 6729", imageName: "phone.fill")
                InfoView(text: "91hongppie.gmail", imageName: "envelope.fill")

            }


        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


