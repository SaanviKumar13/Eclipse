//
//  HomeView.swift
//  Eclipse
//
//  Created by user@87 on 21/10/24.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var isUserProfilePresented = false

    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                HStack {
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle()) // Use PlainTextFieldStyle for a custom style
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color(UIColor.systemGray6))) // Rounded background
                        .frame(maxWidth: .infinity)
                        .padding(.trailing, 10) // Add space between text field and image

                    Button(action: {
                        isUserProfilePresented.toggle()
                    }) {
                        Image("userpic")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .padding(.top, 5) 
                    }
                }
                .padding()
                .sheet(isPresented: $isUserProfilePresented) {
                    UserProfileView()
                }
                Spacer()
                Text("Welcome to Eclipse!")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.gray)
            }
        } detail: {
            Text("Select an item from the list")
                .font(.title)
                .foregroundColor(.gray)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

