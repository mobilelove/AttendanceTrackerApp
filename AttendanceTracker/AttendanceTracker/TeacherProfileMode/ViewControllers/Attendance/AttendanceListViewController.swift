//
//  AttendanceListViewController.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/4/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class AttendanceListViewController: UIViewController {
    
    fileprivate var broadcasting: Bool = false
    fileprivate var beacon: CLBeaconRegion?
    fileprivate var peripheralManager: CBPeripheralManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        let uuid: UUID = UUID(uuidString: "0B3C5964-4BCF-4A8A-A325-3ADA8BBBC5DA")!
        
        let major: CLBeaconMajorValue = CLBeaconMajorValue(100)
        let minor: CLBeaconMinorValue = CLBeaconMinorValue(10)
        
        self.beacon = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: "com.vimalveerachamy.AttendanceTracker")
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    @IBAction func startBroadCastingBeacon(_ sender: Any) {
        
        let state: CBManagerState = self.peripheralManager!.state
        
        if (state == .poweredOff && !self.broadcasting) {
            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            let alert: UIAlertController = UIAlertController(title: "Bluetooth OFF", message: "Please power on your Bluetooth!", preferredStyle: .alert)
            alert.addAction(OKAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        self.broadcasting = !broadcasting
        
        self.advertising(start: self.broadcasting)
    }
    
    func advertising(start: Bool) -> Void
    {
        if self.peripheralManager == nil {
            return
        }
        
        
        let rippleLayer = RippleLayer()
        rippleLayer.position = CGPoint(x: self.view.layer.bounds.midX, y: self.view.layer.bounds.midY);
        
        self.view.layer.addSublayer(rippleLayer)
        
        
        if (!start) {
            self.peripheralManager!.stopAdvertising()
            rippleLayer.removeFromSuperlayer()
            return
        }
        
        let state: CBManagerState = self.peripheralManager!.state
        
        if (state == .poweredOn) {
            let UUID:UUID = (self.beacon?.proximityUUID)!
            let serviceUUIDs: Array<CBUUID> = [CBUUID(nsuuid: UUID)]
        
            var peripheralData: Dictionary<String, Any> = self.beacon!.peripheralData(withMeasuredPower: 1)  as NSDictionary as! Dictionary<String, Any>
            peripheralData[CBAdvertisementDataLocalNameKey] = "iBeacon Demo"
            peripheralData[CBAdvertisementDataServiceUUIDsKey] = serviceUUIDs
            
            rippleLayer.startAnimation()
            self.peripheralManager!.startAdvertising(peripheralData)
        }
    }
    
    
    
    deinit
    {
        self.beacon = nil
        self.peripheralManager = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - CBPeripheralManager Delegate -

extension AttendanceListViewController: CBPeripheralManagerDelegate
{
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager)
    {
        let state: CBManagerState = peripheralManager!.state
        
        if state == .poweredOff {

        }
        
        if state == .unsupported {
            
        }
        
        if state == .poweredOn {
            
        }
    }
}
