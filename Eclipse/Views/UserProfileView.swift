//
//  UserProfileView.swift
//  Eclipse
//
//  Created by user@87 on 21/10/24.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                // Header with user's image and name
                VStack {
                    Image("userpic") // Replace with your actual image asset name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    
                    Text("John Doe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()

                List {
                    Section(header: Text("Account")) {
                        NavigationLink("Edit Profile", destination: ContentView())
                        NavigationLink("Notifications", destination: ContentView())
                        NavigationLink("Book Support", destination: ContentView())
                        NavigationLink("Security", destination: ContentView())
                    }
                    
                    Section(header: Text("Actions")) {
                        NavigationLink("Report a Problem", destination: ContentView())
                        NavigationLink("Add Account", destination: ContentView())
                        Button("Log Out") {
                            
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                Spacer()
            }
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            })
        }
    }
}

#Preview {
    UserProfileView()
}

