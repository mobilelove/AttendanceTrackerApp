//
//  ClassesViewController.swift
//  AttendanceTracker
//
//  Created by MobileLove on 3/31/18.
//  Copyright © 2018 MobileLove. All rights reserved.
//

import UIKit

class ClassesViewController: UIViewController, YALTabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tabBarWillExpand(_ tabBar: YALFoldingTabBar) {
        print("will expand")
    }
    
    func tabBarDidExpand(_ tabBar: YALFoldingTabBar) {
        print("did expand")
    }
    
    func tabBarWillCollapse(_ tabBar: YALFoldingTabBar) {
        print("will collapse")
    }
    
    func tabBarDidCollapse(_ tabBar: YALFoldingTabBar) {
        print("did collapse")
    }

}
