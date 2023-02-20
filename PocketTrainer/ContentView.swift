//
//  ContentView.swift
//  PocketTrainer
//
//  Created by Bruce Tukuafu on 1/26/23.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { result, error in
            guard result != nil, error == nil else{
                        return
                    }
                    // success
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else{
                return
            }
            // success
        }
    }
    
}

struct ContentView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("PocketTrainer")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                
                VStack{
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action:{
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        viewModel.signIn(email: email, password: password)
                    }, label: {
                        
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                        
                    })
                    
                    HStack {
                        Text("Or sign up with:")
                            .font(.caption)
                        
                        Button(action: {
                            // handle Twitter sign up
                        }, label: {
                            Image("Twitter")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                        })
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        
                        Button(action: {
                            // handle Facebook sign up
                        }, label: {
                            Image("Facebook")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                        })
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .padding(.top, 16)
                    
                    Button(action: {
                        // handle forgot password
                    }, label: {
                        Text("Forgot your password?")
                            .font(.caption)
                            .foregroundColor(.blue)
                    })
                    .padding(.top, 8)
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    // handle sign up
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.green)
                })
                .padding(.bottom, 16)
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
