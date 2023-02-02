//
//  ContentView.swift
//  PocketTrainer
//
//  Created by Bruce Tukuafu on 1/26/23.
//

import SwiftUI

struct ContentView: View {
    @State var email = ""
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                VStack{
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    SecureField("Password", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    Button(action:{}, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                        
                        
                    })
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Sign In")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
