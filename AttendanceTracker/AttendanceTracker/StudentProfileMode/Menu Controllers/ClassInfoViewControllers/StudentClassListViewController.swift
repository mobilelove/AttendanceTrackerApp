//
//  StudentClassListViewController.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/8/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import CoreBluetooth
import CoreLocation

class StudentClassListViewController: UIViewController, SideMenuItemContent, Storyboardable, UITableViewDataSource, UITableViewDelegate {
    
    var classInfoDataSource : Array<Any>? = nil
    
    fileprivate var beacons: [CLBeacon] = []
    fileprivate var location: CLLocationManager?
    fileprivate var attendanceRequestIndicator: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let homeDataContentPath = Bundle.main.path(forResource: "StudentClassInfo", ofType: ".plist") {
            self.classInfoDataSource = NSArray(contentsOfFile: homeDataContentPath) as? Array<Any>
        }
        
        self.location = CLLocationManager()
        self.location!.delegate = self
        self.attendanceRequestIndicator = true
    }
    
    deinit {
        self.location = nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func openMenu(_ sender: Any) {
        showSideMenu()
    }
    
    //MARK: - UITableView Datasource and Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.classInfoDataSource?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "StudentClassInfo", for: indexPath) as! StudentClassInfoCell
        let classInfo = self.classInfoDataSource![indexPath.row] as! Dictionary<String, String>
        tableViewCell.configureCellWith(name: classInfo["className"]!, id: classInfo["classID"]!, time: classInfo["classTime"]!)
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.sendRequestForAttendence()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension StudentClassListViewController {
    
    func sendRequestForAttendence() -> Void {
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
    
    func notifyForRequestForAttendance()-> Void {
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let alert: UIAlertController = UIAlertController(title: "Alert", message: "Your attendence for the class has been succesfully registered", preferredStyle: .alert)
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion: nil)
        self.attendanceRequestIndicator = false
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

extension StudentClassListViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        guard status == .authorizedAlways else {
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
            self.location?.stopRangingBeacons(in: region as! CLBeaconRegion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Beacon in range")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("No beacons in range")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion)
    {
        self.beacons = beacons
        self.notifyForRequestForAttendance()
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
