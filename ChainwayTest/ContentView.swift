//
//  ContentView.swift
//  ChainwayTest
//
//  Created by Alex Dobler on 17.12.23.
//

import SwiftUI

struct BluetoothDevice: Identifiable, Hashable {
    let id = UUID() // Unique identifier for each device
    var name: String
    var address: UUID
    var bondState: Int
    
}

struct ContentView: View {
    @State private var showingDeviceList = false
    @State private var devices: [BluetoothDevice] = []
    
    let deviceManager = DeviceListManager()
    let scannerManager = RFIDScannerManager()
    var body: some View {
        VStack {
            Button(action: deviceManager.startBLEScanning) {
                Text("Start BLE scanning")
            }
            Spacer().frame(height: 30)
            Button(action: deviceManager.stopBLEScanning) {
                Text("Stop BLE scanning")
            }
            Spacer().frame(height: 30)
            Button("Show Devices") {
                self.devices = deviceManager.getAvailableDevices().map {
                    BluetoothDevice(name: $0["name"] as? String ?? "Unknown",
                                    address: $0["address"] as? UUID ?? UUID(),
                                    bondState: $0["bondState"] as? Int ?? 0)
                }
                self.showingDeviceList = true
            }
            Spacer().frame(height: 30)
            Button(action: scannerManager.startScanningRFID) {
                Text("Start RFID scanning")
            }
            Spacer().frame(height: 30)
            Button(action: scannerManager.stopScanningRFID) {
                Text("Stop RFID scanning")
            }
        }
        .padding()
        .sheet(isPresented: $showingDeviceList) {
            DeviceListView(devices: self.devices){ identifier in
                deviceManager.connectToDevice(with: identifier)
            }
        }
    }
}

struct DeviceListView: View {
    var devices: [BluetoothDevice]
    let onDeviceTap: (UUID) -> Void
    //var devices: [BluetoothDevice]

    var body: some View {
        List(devices, id: \.self) { device in
            HStack {
                Text("Name: \(device.name)")
                Spacer()
                Text("Address: \(device.address)")
                Spacer()
                Text("Bond State: \(device.bondState)")
            }
            .contentShape(Rectangle()) // This makes the entire row tappable
            .onTapGesture {
                onDeviceTap(device.address)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
