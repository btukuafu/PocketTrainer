//
//  TrainView.swift
//  PocketTrainer
//
//  Created by Armin Rostami on 2/28/23.
//


import SwiftUI
import FirebaseAuth
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject{
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
        
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "Unamed device")
        }
    }
}

struct TrainView: View {
    
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()

    @State private var exerciseType = "Bench Press"
    @State private var weight = ""
    @State private var reps = ""
    @State private var sets = ""
    @State private var isWorkoutInProgress = false
    @State private var isShowingSettings = false
 
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    Spacer()
                    Button(action: {
                        // code to go to settings page
                        isShowingSettings = true
                    }) {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.top, 2)
                    .sheet(isPresented: $isShowingSettings) {
                        SettingsView()
                    }
                }
                .padding(.horizontal)

                HStack {
                    
                    NavigationLink(destination: BluetoothView()){
                        (Text("Connect to Bluetooth") + Text(Image(systemName: "bolt.fill")))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.blue)
                        
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
                        .keyboardType(.decimalPad)

                    TextField("Reps", text: $reps)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .keyboardType(.decimalPad)

                    TextField("Sets", text: $sets)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .keyboardType(.decimalPad)
                    
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
                .onTapGesture {
                    hideKeyboard()
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
}
extension TrainView {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
struct Trainview_Previews: PreviewProvider {
    static var previews: some View {
        TrainView()
    }
}

struct BluetoothView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
    var body: some View {
        NavigationView {
            List(bluetoothViewModel.peripheralNames, id: \.self) {
                peripheral in Text(peripheral)
            }
            .navigationTitle("Bluetooth Devices")
        }
    }
}


struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account")) {
                    NavigationLink(destination: AccountSettingsView()) {
                        Text("Edit Profile")
                    }
                    NavigationLink(destination: SecuritySettingsView()) {
                        Text("Security")
                    }
                }
                
                Section(header: Text("General")) {
                    Toggle("Notifications", isOn: .constant(false))
                    NavigationLink(destination: HelpView()) {
                        Text("Help")
                    }
                }
                
                Section(header: Text("About")) {
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Settings")
        }
    }
}

struct AccountSettingsView: View {
    var body: some View {
        Text("Account Settings")
            .navigationBarTitle("Edit Profile")
    }
}

struct SecuritySettingsView: View {
    var body: some View {
        Text("Security Settings")
            .navigationBarTitle("Security")
    }
}

struct HelpView: View {
    var body: some View {
        Text("Help")
            .navigationBarTitle("Help")
    }
}

struct AboutView: View {
    var body: some View {
        Text("About")
            .navigationBarTitle("About")
    }
}
