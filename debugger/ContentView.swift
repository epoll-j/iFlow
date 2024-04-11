//
//  ContentView.swift
//  test
//
//  Created by dubhe on 2024/4/7.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        NavigationView(content: {
            HomePage().navigationBarTitle(Text("home"), displayMode: .large)
        })
    }
}


#Preview {
    ContentView()
}
