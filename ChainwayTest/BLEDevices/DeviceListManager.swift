//
//  DeviceListManager.swift
//  Pods
//
//  Created by Alex Dobler on 12.12.23.
//

import Foundation
import os

class DeviceListManager: NSObject, FatScaleBluetoothManager, PeripheralAddDelegate {
    private var rfidBluetoothManager: RFIDBlutoothManager
    //private var discoveredDevices: [CBPeripheral] = []
    private var discoveredDevices: [BLEModel] = []
    
    @available(iOS 14.0, *)
    private static let logger = Logger(
            subsystem: Bundle.main.bundleIdentifier!,
            category: String(describing: DeviceListManager.self)
        )
    
    override init() {
        //rfidBluetoothManager = RFIDBlutoothManager.shareManager()
        rfidBluetoothManager = RFIDBlutoothManager.share()
        // Set up the delegate or notification observers if needed
        if #available(iOS 14.0, *) {
            Self.logger.trace("setup DeviceListManager")
        } else {
            // Fallback on earlier versions
        }
    }

    func startBLEScanning() {
        NSLog("Starting BLE Scanning")
        if #available(iOS 14.0, *) {
            Self.logger.trace("starting the BLE scanning")
        } else {
            // Fallback on earlier versions
        }
        rfidBluetoothManager.setFatScaleBluetoothDelegate(self)
        rfidBluetoothManager.setPeripheralAddDelegate(self)
        rfidBluetoothManager.bleDoScan()
        if #available(iOS 14.0, *) {
            Self.logger.trace("Start BLE Scanning seems to work")
        } else {
            // Fallback on earlier versions
        }
    }
    
    func stopBLEScanning() {
            if #available(iOS 14.0, *) {
                Self.logger.trace("Stopping the BLE scanning")
            } else {
                // Fallback on earlier versions
                NSLog("Stopping BLE Scanning")
            }

            // Stop the scanning process in RFIDBlutoothManager
            rfidBluetoothManager.closeBleAndDisconnect()
        }
    
    
    func handleNewDevice(_ device: BLEModel) {
        if let name = device.nameStr, let peripheral = device.peripheral, !discoveredDevices.contains(where: { $0.peripheral.identifier == peripheral.identifier }) {
            if #available(iOS 14.0, *) {
                Self.logger.trace("Adding peripheral to list with name: \(name) and address: \(peripheral.identifier)")
            } else {
                // Fallback on earlier versions
            }
            discoveredDevices.append(device)
        }
    }
    
    func getAvailableDevices() -> [[String: Any]] {
        //let foundDevices = rfidBluetoothManager.peripheralArray
        //return foundDevices

        return discoveredDevices.map { device in
            let bondState = device.peripheral?.state.rawValue ?? -1
            if let peripheralIdentifier = device.peripheral?.identifier {
                return [
                    "name": device.nameStr ?? "",
                    "address": peripheralIdentifier,//device.addressStr ?? "",
                    // Assuming bondState is to be derived from peripheral state
                    "bondState": bondState
                    // You can also include the RSSI if needed, e.g., "rssi": device.rssStr
                ]
            }
            else{
                return [
                    "name": "Invalid Device",
                    "address": "Invalid Identifier",
                    "bondState": -1
                ]
            }
        }
    
    }
    
    func connectToDevice(with identifier: UUID) {
        if let deviceToConnect = discoveredDevices.first(where: { $0.peripheral.identifier == identifier }) {
            rfidBluetoothManager.connect(deviceToConnect.peripheral, macAddress: deviceToConnect.addressStr)
        } else {
            print("Device not found")
        }
    }

    //required for FatScaleBluetoothManager
    @objc func connectBluetoothFail(withMessage msg: String) {
        if #available(iOS 14.0, *) {
            Self.logger.error("Connecting to Bluetooth failed!")
        } else {
            // Fallback on earlier versions
        }
        // Handle the connection failure
    }
    
    @objc func connectPeripheralSuccess(_ nameStr: String!) {
        if #available(iOS 14.0, *) {
            Self.logger.error("Connecting peripheral successful")
        } else {
            // Fallback on earlier versions
        }
    }
    
    //required for PeripheralAddDelgate
    @objc func addPeripheralWith(_ peripheralModel: BLEModel) {
        NSLog("Found peripheral");
        if #available(iOS 14.0, *) {
            Self.logger.trace("Peripheral found")
        } else {
            // Fallback on earlier versions
        }
        self.handleNewDevice(peripheralModel)
    }
    
    @objc func rcvData(_ model: BLEModel, result: String)  {
        if #available(iOS 14.0, *) {
            Self.logger.trace("Received data from BLE model: \(model), result: \(result)")
        } else {
            // Fallback on earlier versions
        }
        self.handleNewDevice(model)
    }
}
