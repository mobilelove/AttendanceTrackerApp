//
//  StudentProfileViewController.swift
//  AttendanceTracker
//
//  Created by VIMAL KUMAR VEERACHAMY on 4/1/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class StudentProfileViewController: UIViewController, SideMenuItemContent, Storyboardable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func openMenu(_ sender: UIButton) {
        showSideMenu()
    }

}
