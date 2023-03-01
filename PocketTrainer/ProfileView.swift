//
//  ProfileView.swift
//  PocketTrainer
//
//  Created by Armin Rostami on 3/1/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()

            Text("John Doe")
                .font(.title)

            Text("Location: New York")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)

            NavigationLink(destination: PersonalInfoView()) {
                HStack {
                    Image(systemName: "person.fill")
                    Text("Personal Information")
                }
                .padding()
            }

            NavigationLink(destination: NotificationView()) {
                HStack {
                    Image(systemName: "bell.fill")
                    Text("Notification")
                }
                .padding()
            }

            NavigationLink(destination: PostWorkoutView()) {
                HStack {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Post Workout")
                }
                .padding()
            }

            NavigationLink(destination: TrackProgressView()) {
                HStack {
                    Image(systemName: "chart.pie.fill")
                    Text("Track your progress")
                }
                .padding()
            }

            Spacer()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
        .navigationBarItems(
            trailing: Button(action: {
                viewModel.signOut()
            }) {
                Text("Sign Out")
            }
        )
    }
}

struct PersonalInfoView: View {
    var body: some View {
        Form {
            Section(header: Text("Account Information")) {
                TextField("Name", text: .constant("John Doe"))
                TextField("Username", text: .constant("johndoe"))
                TextField("Email", text: .constant("johndoe@gmail.com"))
                TextField("Phone Number", text: .constant("123-456-7890"))
            }

            Section {
                Button(action: {
                    // handle save button press
                }, label: {
                    Text("Save")
                })
            }
        }
        .navigationBarTitle("Personal Information")
    }
}


struct PostWorkoutView: View {
    var body: some View {
        VStack {
            Text("Post Workout")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
            
            Text("Post workout analytics and data will be displayed here")
                .foregroundColor(.secondary)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Post Workout")
    }
}

struct NotificationView: View {
    @State var enableNotification = false
    
    var body: some View {
        VStack {
            Text("Notification")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
            
            Toggle(isOn: $enableNotification, label: {
                Text("Enable Notification")
            })
            .padding()
            
            Spacer()
        }
        .navigationTitle("Notification")
    }
}

struct TrackProgressView: View {
    @State var weight = ""
    @State var height = ""
    @State var goalWeight = ""
    
    var body: some View {
        VStack {
            Text("Track Your Progress")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
            
            VStack {
                HStack {
                    Text("Weight")
                    TextField("Enter your weight", text: $weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
                
                HStack {
                    Text("Height")
                    TextField("Enter your height", text: $height)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
                
                HStack {
                    Text("Goal Weight")
                    TextField("Enter your goal weight", text: $goalWeight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
                
                Button(action: {
                    // Save progress
                }, label: {
                    Text("Save Progress")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                })
                .padding()
            }
            
            Spacer()
        }
        .navigationTitle("Track Your Progress")
    }
}

