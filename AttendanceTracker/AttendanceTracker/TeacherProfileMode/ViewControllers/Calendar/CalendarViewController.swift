//
//  CalendarViewController.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/7/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
