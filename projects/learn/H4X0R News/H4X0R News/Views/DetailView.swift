//
//  DetailView.swift
//  H4X0R News
//
//  Created by Kyuhong Jo on 2023/07/11.
//


import SwiftUI

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}

