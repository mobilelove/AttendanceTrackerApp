//
//  ClassesViewController.swift
//  AttendanceTracker
//
//  Created by MobileLove on 3/31/18.
//  Copyright © 2018 MobileLove. All rights reserved.
//

import UIKit

class ClassesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var classInfoDataSource : Array<Any>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        if let homeDataContentPath = Bundle.main.path(forResource: "ClassInfo", ofType: ".plist") {
            self.classInfoDataSource = NSArray(contentsOfFile: homeDataContentPath) as? Array<Any>
        }
        
    }
    
    //MARK: - UITableView Datasource and Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.classInfoDataSource?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ClassInfo", for: indexPath) as! ClassInfoCell
        let classInfo = self.classInfoDataSource![indexPath.row] as! Dictionary<String, String>
        tableViewCell.configureCellWith(name: classInfo["className"]!, idValue: classInfo["classID"]!)
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
