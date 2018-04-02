//
//  CalendarViewController.swift
//  AttendanceTracker
//
//  Created by MobileLove on 3/31/18.
//  Copyright © 2018 MobileLove. All rights reserved.
//

import UIKit

enum MyTheme {
    case light
    case dark
}

class AttendanceViewController: UIViewController, YALTabBarDelegate, CalenderDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Calender"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.bgColor
        
        
        view.addSubview(calenderView)
        calenderView.delegate = self
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive=true
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarBtnAction))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func rightBarBtnAction(sender: UIBarButtonItem) {
        print(123)
    }
    
    @objc func dismissVC(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    lazy var  calenderView: CalenderView = {
        let calenderView = CalenderView(theme: MyTheme.light)
        calenderView.translatesAutoresizingMaskIntoConstraints=false
        return calenderView
    }()
    
    func didTapDate(date: String, available: Bool) {
        if available == true {
            print(date)
        } else {
            showAlert()
        }
    }
    
    
    
    fileprivate func showAlert(){
        let alert = UIAlertController(title: "Unavailable", message: "This slot is already booked.\nPlease choose another date.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
