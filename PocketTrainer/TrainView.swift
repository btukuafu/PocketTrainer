//
//  TrainView.swift
//  PocketTrainer
//
//  Created by Armin Rostami on 2/28/23.
//


import SwiftUI
import FirebaseAuth

struct TrainView: View {

    @State private var exerciseType = "Bench Press"
    @State private var weight = ""
    @State private var reps = ""
    @State private var sets = ""
    @State private var isWorkoutInProgress = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // code to go to Profile tab
                }) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }

                Spacer()

                Menu {
                    Button(action: {
                        // code to go to Train tab
                    }) {
                        Label("Train", systemImage: "weightlifting")
                    }

                    Button(action: {
                        // code to go to Setting tab
                    }) {
                        Label("Setting", systemImage: "gearshape")
                    }

                    Button(action: {
                        // code to go to Profile tab
                    }) {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(.top, 2)
            }
            .padding(.horizontal)

            HStack {
                Text("Connect to Bluetooth")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.blue)

                Button(action: {
                    // code to try and connect to Bluetooth
                }) {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.blue)
                        .frame(width: 1, height: 1)
                }
            }
            .padding(.top, 30)

            VStack {
                Picker("Exercise Type", selection: $exerciseType) {
                    Text("Bench Press").tag("Bench Press")
                    Text("Squat").tag("Squat")
                    Text("Deadlift").tag("Deadlift")
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .onChange(of: exerciseType) { _ in
                    // handle changing exercise type
                    weight = ""
                    reps = ""
                    sets = ""
                }

                TextField("Weight (lbs)", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Reps", text: $reps)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Sets", text: $sets)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    isWorkoutInProgress.toggle()
                    // code to start workout
                }) {
                    Text("Start workout")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }

            if isWorkoutInProgress {
                Text("Work in progress")

                Button(action: {
                    isWorkoutInProgress.toggle()
                    // code to stop workout
                }) {
                    Text("Stop")
                }
            }
            Spacer()
        }
    }
}

struct Trainview_Previews: PreviewProvider {
    static var previews: some View {
        TrainView()
    }
}
