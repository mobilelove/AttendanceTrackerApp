//
//  StudentClassesViewController.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/1/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import CoreBluetooth
import CoreLocation

class StudentClassesViewController: UIViewController, SideMenuItemContent, Storyboardable {
    
    fileprivate var beacons: [CLBeacon] = []
    fileprivate var location: CLLocationManager?
    fileprivate var attendanceRequestIndicator: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.location = CLLocationManager()
        self.location!.delegate = self
        self.attendanceRequestIndicator = true
    }

    deinit {
        self.location = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Show side menu on menu button click
    @IBAction func openMenu(_ sender: UIButton) {
        showSideMenu()
    }
}

extension StudentClassesViewController {
    
    @IBAction func refreshBeacons(sender: Bool) -> Void
    {
        // This uuid must same as broadcaster.
        let uuid: UUID = UUID(uuidString: "0B3C5964-4BCF-4A8A-A325-3ADA8BBBC5DA")!
        
        let major: CLBeaconMajorValue = CLBeaconMajorValue(100)
        let minor: CLBeaconMinorValue = CLBeaconMinorValue(10)
        
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: "com.vimalveerachamy.AttendanceTracker")
        
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true
        
        self.location!.requestAlwaysAuthorization()
        self.location!.startMonitoring(for: beaconRegion)
        self.location?.startUpdatingLocation()
    }
    
    //MARK: - Other Method
    
    private func notifiBluetoothOff()
    {
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        let alert: UIAlertController = UIAlertController(title: "Bluetooth OFF", message: "Please power on your Bluetooth!", preferredStyle: .alert)
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension StudentClassesViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        guard status == .authorizedAlways else {
            print("******** User not authorized !!!!")
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        self.location?.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion)
    {
        if state == .inside {
            self.location?.startRangingBeacons(in: region as! CLBeaconRegion)
        }else{
            //self.location?.stopRangingBeacons(in: region as! CLBeaconRegion)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        print("Beacon in range")
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        print("No beacons in range")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion)
    {
        self.beacons = beacons
        
        print("\(self.beacons.first!)")
        
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        let alert: UIAlertController = UIAlertController(title: "Request For Attendance", message: "\(self.beacons.first!)", preferredStyle: .alert)
        
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion: nil)
        
        self.attendanceRequestIndicator = false
        
        manager.stopRangingBeacons(in: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print(error)
    }
    
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print(error)
    }
}
