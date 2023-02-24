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
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                // success
                self?.signedIn = true
            }
            
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                // success
                self?.signedIn = true
            }
            
        }
    }
    
}

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn{
                Text("You are signed In")
            }
            else{
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Text("PocketTrainer")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
            
            VStack{
                TextField("Email Address", text: $email)
                    .disableAutocorrection(false)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .disableAutocorrection(false)
                    .autocapitalization(.none)
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
                .padding()
                
                Text("Don't have an account?")
                NavigationLink("Sign Up", destination: SignUpView())
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Sign In")
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Text("PocketTrainer")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
            
            VStack{
                TextField("Email Address", text: $email)
                    .disableAutocorrection(false)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .disableAutocorrection(false)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button(action:{
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    viewModel.signUp(email: email, password: password)
                    
                }, label: {
                    
                    Text("Sign Up")
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
            
        }
        .navigationTitle("Sign Up")
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
