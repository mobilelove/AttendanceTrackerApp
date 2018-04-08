//
//  HomeViewController.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/7/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var homeDataSource : Array<Any>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let homeDataContentPath = Bundle.main.path(forResource: "Home", ofType: ".plist") {
            homeDataSource = NSArray(contentsOfFile: homeDataContentPath) as? Array<Any>
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UITableView Datasource and Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sectionCount = homeDataSource?.count{
            return sectionCount
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo : NSDictionary = self.homeDataSource![section] as! NSDictionary
        let rowInfo = sectionInfo["Rows"] as? Array<Any>
        
        if let rowCount = rowInfo?.count{
            return rowCount
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1{
            let tableviewCell = tableView.dequeueReusableCell(withIdentifier: "SectionInfo") as! SectionInfoCell
            tableviewCell.sectionNameLbl?.text = "Class Informations"
            return tableviewCell
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(section == 1){
            return 40
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionInfo : NSDictionary = self.homeDataSource![indexPath.section] as! NSDictionary
        let rowInfo = sectionInfo["Rows"] as? Array<Any>
        let homeInfo = rowInfo![indexPath.row] as! Dictionary<String, String>
        
        if(indexPath.section == 0){
            let tableviewCell = tableView.dequeueReusableCell(withIdentifier: "HomeTeacherInfo", for: indexPath) as! HomeTeacherInfoCell
            tableviewCell.configureTeacherCellWith(imageName: homeInfo["imageName"]!, name: homeInfo["teacherName"]!, id: homeInfo["teacherID"]!)
            
            return tableviewCell
        }else{
            
            let tableviewCell = tableView.dequeueReusableCell(withIdentifier: "HomeClassInfo", for: indexPath) as! HomeClassInfoCell
            tableviewCell.configureClassInfoCellWith(name: homeInfo["className"]!, id: homeInfo["classID"]!, time: homeInfo["classTime"]!)
            tableviewCell.selectionStyle = .none
            
            return tableviewCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
