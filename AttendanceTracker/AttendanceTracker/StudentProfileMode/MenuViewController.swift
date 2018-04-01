//
//  MenuViewController.swift
//  Interactive Menu
//
//  Created by Darren Kent on 1/11/18.
//  Copyright © 2018 Darren Kent. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MenuAnimationDelegate {
    
    @IBOutlet weak var uxMenuTable: UITableView!
    
    var iController: UIPercentDrivenInteractiveTransition?
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    let menuItems:[String] = ["Classes","Attendance","Report","Profile", "Help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        createTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTable(){
        
        uxMenuTable.delegate = self
        uxMenuTable.dataSource = self
        uxMenuTable.allowsSelection = false
        uxMenuTable.showsVerticalScrollIndicator = false
        uxMenuTable.showsHorizontalScrollIndicator = false
        
        let headerView = UIView()
        let footerView = UIView()
        
        headerView.frame = CGRect(x: 0, y: 0, width: uxMenuTable.frame.width, height: 30)
        
        uxMenuTable.tableHeaderView = headerView
        uxMenuTable.tableFooterView = footerView
    }
    
    // MARK: - Tap Gesture
    
    func createTapGesture(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        
        self.performSegue(withIdentifier: "UnwindToHomeSegue", sender: self)
    }
    
    // MARK: - Menu Animation Protocol
    
    func handleTapProtocol(_ gesture: UITapGestureRecognizer){
        
        self.performSegue(withIdentifier: "UnwindToHomeSegue", sender: self)
    }
    
    func handlePanProtocol(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: gesture.view)
        
        //* 1.2 Increases the velocity.
        let percent = ((-translation.x * 1.2) / gesture.view!.bounds.size.width)
        
        let translationX = abs(translation.x)//Absolute value.
        let translationY = abs(translation.y)//Absolute value.
        
        if gesture.state == .began {
            
            iController = UIPercentDrivenInteractiveTransition()
            MenuTransitioningDelegate.menuTransitioningSingleton.interactionController = iController
            
            self.performSegue(withIdentifier: "UnwindToHomeSegue", sender: self)
            
        } else if gesture.state == .changed {
            
            //This ends the gesture if there's too much vertical movement.
            //Set between 50 - 100.
            if translationY > 100 {
                
                gesture.isEnabled = false
                
            }else if translationX > 10 && percent < 1.0{
                
                iController?.update(percent)
            }
            
        }else if gesture.state == .ended || gesture.state == .cancelled{
            
            if percent > 0.3 {
                
                iController?.finish()
                
            }else{
                
                iController?.cancel()
            }
            
            gesture.isEnabled = true
            iController = nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = uxMenuTable.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        let row = indexPath.row
        
        let cellIdentity = menuItems[row]
        
        cell.uxMenuName.text = cellIdentity
        
        if cellIdentity == "Profile"{
            
            cell.uxMenuIcon.image = #imageLiteral(resourceName: "iSetProfile")
            
        }else if cellIdentity == "Classes"{
            
            cell.uxMenuIcon.image = #imageLiteral(resourceName: "classes")
            
        }else if cellIdentity == "Attendance"{
            
            cell.uxMenuIcon.image = #imageLiteral(resourceName: "attendance")
            
        }else if cellIdentity == "Help"{
            
            cell.uxMenuIcon.image = #imageLiteral(resourceName: "iSetFAQ")
            
        }else if cellIdentity == "Report"{
            
            cell.uxMenuIcon.image = #imageLiteral(resourceName: "Report")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     }
 
}
