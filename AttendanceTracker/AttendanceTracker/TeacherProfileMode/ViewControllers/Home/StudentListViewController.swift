//
//  StudentListViewController.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/7/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class StudentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var broadcasting: Bool = false
    fileprivate var beacon: CLBeaconRegion?
    fileprivate var peripheralManager: CBPeripheralManager?
    
    fileprivate let rippleLayer = RippleLayer()
    
    var studentsDataSource : Array<Any>?
    
    @IBOutlet var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let studentsContextPath = Bundle.main.path(forResource: "Students", ofType: "plist")
        self.studentsDataSource = NSArray(contentsOfFile: studentsContextPath!) as? Array<Any>
        
        let uuid: UUID = UUID(uuidString: "0B3C5964-4BCF-4A8A-A325-3ADA8BBBC5DA")!
        
        let major: CLBeaconMajorValue = CLBeaconMajorValue(100)
        let minor: CLBeaconMinorValue = CLBeaconMinorValue(10)
        
        self.beacon = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: "com.vimalveerachamy.AttendanceTracker")
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
    }

    override func willMove(toParentViewController parent: UIViewController?) {
        
        if parent == nil {
            
            if self.broadcasting {
                self.peripheralManager!.stopAdvertising()
                self.rippleLayer.stopAnimation()
                self.rippleLayer.removeFromSuperlayer()
            }
        }
    }
    
    
    func showAlertForBroadcastingModal() -> Void {
        
        let OKAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (alert: UIAlertAction!) in
            self.peripheralManager!.stopAdvertising()
            
            self.rippleLayer.stopAnimation()
            
            self.rippleLayer.removeFromSuperlayer()
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let alert: UIAlertController = UIAlertController(title: "Alert", message: "Would you like to stop broascasting signal", preferredStyle: .alert)
        alert.addAction(OKAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startBroadCastingBeacon(_ sender: Any) {
        
        let state: CBManagerState = self.peripheralManager!.state
        
        if self.broadcasting {
            self.showAlertForBroadcastingModal()
            return
        }
        
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
        
        self.rippleLayer.position = CGPoint(x: self.view.layer.bounds.midX, y: self.view.layer.bounds.midY);
        self.tableView?.layer.addSublayer(rippleLayer)
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.studentsDataSource?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let studentInfo = self.studentsDataSource![indexPath.row] as! NSDictionary
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentInfo", for: indexPath) as? StudentInfoCell
        
        tableViewCell?.configureStudentInfoCellWith(imageName: studentInfo["imageName"]! as! String, name: studentInfo["studName"]! as! String, id: studentInfo["studID"]! as! String, status: studentInfo["status"]! as! Bool)
        
        tableViewCell?.selectionStyle = .none
        
        return tableViewCell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - CBPeripheralManager Delegate -

extension StudentListViewController: CBPeripheralManagerDelegate
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
