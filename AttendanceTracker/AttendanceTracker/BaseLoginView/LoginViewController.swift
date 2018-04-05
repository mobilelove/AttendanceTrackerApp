//
//  ViewController.swift
//  LoginSignUpSwipe
//
//  Created by Alexej Nenastev on 03.05.17.
//  Copyright © 2017 Alexej Nenastev. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class LoginViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var UsernameTxtField: CustomTextField!
    @IBOutlet weak var PasswordTxtField: CustomTextField!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        UsernameTxtField.delegate = self
        PasswordTxtField.delegate = self
        
       }
    
    @IBAction func LoginBtn(_ sender: Any) {
    
        if(self.UsernameTxtField.text == "teacher"){
            self.setupTeacherProfileView()
        }else{
            self.setupStudentProfileView()
        }
    }
    
    @IBAction func SignupBtn(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let signup = story.instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
        self.present(signup, animated: true, completion: nil)
        
    }
    
    
    func setupTeacherProfileView() -> Void {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "FoldingTabBarController") as? YALFoldingTabBarController
        
        
        let item1 = YALTabBarItem(itemImage: UIImage(named: "nearby_icon"), leftItemImage: nil, rightItemImage: nil)
        let item2 = YALTabBarItem(itemImage: UIImage(named: "profile_icon"), leftItemImage: nil, rightItemImage: nil)
        tabBarController?.leftBarItems = [item1, item2]
        
        
        let item3 = YALTabBarItem(itemImage: UIImage(named: "chats_icon"), leftItemImage: nil, rightItemImage: nil)
        let item4 = YALTabBarItem(itemImage: UIImage(named: "settings_icon"), leftItemImage: nil, rightItemImage: nil)
        tabBarController?.rightBarItems = [item3, item4]
        
        tabBarController?.centerButtonImage = UIImage(named:"plus_icon")!
        tabBarController?.selectedIndex = 2
        
        //customize tabBarView
        tabBarController?.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
        tabBarController?.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
        tabBarController?.tabBarView.backgroundColor = UIColor(red: 94.0/255.0, green: 91.0/255.0, blue: 149.0/255.0, alpha: 1)
        
        tabBarController?.tabBarView.tabBarColor = UIColor(red: 72.0/255.0, green: 211.0/255.0, blue: 178.0/255.0, alpha: 1)
        tabBarController?.tabBarViewHeight = YALTabBarViewDefaultHeight;
        tabBarController?.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
        tabBarController?.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
        
        self.present(tabBarController!, animated: true, completion: nil)
    }

    
    func setupStudentProfileView() -> Void{
        
        let storyboard = UIStoryboard(name: "StudentProfileMain", bundle: nil)
        let studentVC = storyboard.instantiateInitialViewController()
        
        self.present(studentVC!, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == UsernameTxtField
        {
            PasswordTxtField.becomeFirstResponder()

        }else {
              textField.resignFirstResponder()
        }
        
        return true
      }
    
 }
