//
//  ContentView.swift
//  Eclipse
//
//  Created by user@87 on 21/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.title)
                .padding()
        }
        .padding() // Add padding to the entire VStack
    }
}

#Preview {
    ContentView()
}
