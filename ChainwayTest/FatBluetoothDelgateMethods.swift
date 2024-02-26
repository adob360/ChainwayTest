//
//  FatBluetoothDelgateMethods.swift
//  ChainwayTest
//
//  Created by Alex Dobler on 18.12.23.
//

import Foundation

class FatBluetoothDelgateMethods {
    // MARK: - FatScaleBluetoothManager Delegate Methods

    func connectBluetoothFail(withMessage msg: String) {
        // TODO: Implement this delegate method
    }

    func connectBluetoothTimeout() {
        // TODO: Implement this delegate method
    }

    func receiveData(with parseModel: Any, dataSource: NSMutableArray) {
        // TODO: Implement this delegate method
    }

    func rcvData(_ model: BLEModel, result: String) {
        // TODO: Implement this delegate method
    }

    func receiveDataWithBLEDataSource(
        _ dataSource: NSMutableArray,
        allCount: Int,
        countArr: NSMutableArray,
        dataSource1: NSMutableArray,
        countArr1: NSMutableArray,
        dataSource2: NSMutableArray,
        countArr2: NSMutableArray
    ) {
        // TODO: Implement this delegate method
    }

    func receiveRcodeData(withBLEDataSource dataSource: NSMutableArray) {
        // TODO: Implement this delegate method
    }

    func receiveMessage(withType typeStr: String, dataStr: String) {
        // TODO: Implement this delegate method
    }

    func connectPeripheralSuccess(_ nameStr: String) {
        // TODO: Implement this delegate method
    }

    func disConnectPeripheral() {
        // TODO: Implement this delegate method
    }

    func updateBLENameSuccess() {
        // TODO: Implement this delegate method
    }
}
