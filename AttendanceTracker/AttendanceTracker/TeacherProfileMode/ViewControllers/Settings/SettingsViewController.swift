//
//  SettingsViewController.swift
//  AttendanceTracker
//
//  Created by MobileLove on 3/31/18.
//  Copyright © 2018 MobileLove. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let OKAction:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let alert:UIAlertController = UIAlertController(title: "Alert", message: "Feature development is inprogress", preferredStyle: .alert)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
