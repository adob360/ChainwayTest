//
//  RFIDScannerManager.swift
//  ChainwayTest
//
//  Created by Alex Dobler on 18.12.23.
//

import Foundation
import os

class RFIDScannerManager: NSObject, FatScaleBluetoothManager {
    private var rfidBluetoothManager: RFIDBlutoothManager
    private var scannedTags: [String] = [] // List to store scanned tags
    
    @available(iOS 14.0, *)
    private static let logger = Logger(
            subsystem: Bundle.main.bundleIdentifier!,
            category: String(describing: RFIDScannerManager.self)
        )

    override init() {
        rfidBluetoothManager = RFIDBlutoothManager.share()
        super.init()
        rfidBluetoothManager.setFatScaleBluetoothDelegate(self)
    }
    
    func scanSingleRFID() {
        if #available(iOS 14.0, *) {
            Self.logger.trace("Doing single scan")
        } else {
            // Fallback on earlier versions
        }
        // Initiate a single RFID scan
        rfidBluetoothManager.singleSaveLabel()
    }

    func startScanningRFID() {
        if #available(iOS 14.0, *) {
            Self.logger.trace("Starting RFID scanning")
        } else {
            // Fallback on earlier versions
        }
        // Start continuous RFID scanning
        rfidBluetoothManager.continuitySaveLabel(withCount: "0")
    }

    func stopScanningRFID() {
        if #available(iOS 14.0, *) {
            Self.logger.trace("Stopping RFID scanning")
        } else {
            // Fallback on earlier versions
        }
        // Stop continuous RFID scanning
        rfidBluetoothManager.stopcontinuitySaveLabel()
    }
    
    func addTag(_ tag: String) {
        // Add a found tag to the list if it's not already in there
        if !scannedTags.contains(tag) {
            scannedTags.append(tag)
        }
    }
    
    // Implement the delegate method to receive scanned RFID data
    @objc func rcvRfidData(
            _ dataSource: NSMutableArray,
            allCount: NSInteger,
            countArr: NSMutableArray,
            dataSource1: NSMutableArray,
            countArr1: NSMutableArray,
            dataSource2: NSMutableArray,
            countArr2: NSMutableArray
        ) {
        // Handle the scanned RFID tag data here
        NSLog("rcvRfidData")
        if #available(iOS 14.0, *) {
            //addTag function should be called here
            Self.logger.trace("Got data: \(dataSource)")
            Self.logger.trace("Total Count of Tags: \(allCount)")
            Self.logger.trace("Counts Array: \(countArr)")
            Self.logger.trace("Data Source 1: \(dataSource1)")
            Self.logger.trace("Counts Array 1: \(countArr1)")
            Self.logger.trace("Data Source 2: \(dataSource2)")
            Self.logger.trace("Counts Array 2: \(countArr2)")
        } else {
            // Fallback on earlier versions
        }
    }
    
    //Try implementing another delgate method to see if it receives tags
    func receiveRcodeData(withBLEDataSource dataSource: NSMutableArray) {
        NSLog("receiveRcodeData")
        if #available(iOS 14.0, *) {
            Self.logger.trace("Got data with BLEDataSource: \(dataSource)")
        } else {
            // Fallback on earlier versions
        }
    }

    //Try implementing another delgate method to see if it receives tags
    func receiveMessageWithtype(_ typeStr: String, dataStr: String) {
        NSLog("receiveMessageWithtype")
        if #available(iOS 14.0, *) {
            Self.logger.trace("Received Type String: \(typeStr)")
            Self.logger.trace("Received Data Str: \(dataStr)")
        } else {
            // Fallback on earlier versions
        }
    }
    
    //Try implementing another delgate method to see if it receives tags
    func receiveData(with parseModel: Any, dataSource: NSMutableArray) {
        NSLog("receiveData")
        if #available(iOS 14.0, *) {
            Self.logger.trace("Data source parse model: \(dataSource)")
        } else {
            // Fallback on earlier versions
        }
    }
    
}
