//
//  ViewController.swift
//  LoginSignUpSwipe
//
//  Created by MobileLove on 04.05.18.
//  Copyright © 2018 Alexej Nenastev. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class LoginViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //IBOutlets connection
    @IBOutlet weak var UsernameTxtField: CustomTextField!
    @IBOutlet weak var PasswordTxtField: CustomTextField!
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UsernameTxtField.delegate = self
        PasswordTxtField.delegate = self
        
    }
    
    //MARK: - IBActions methods
    @IBAction func LoginBtn(_ sender: Any) {

                if(self.UsernameTxtField.text == "teacher"){
                    self.setupTeacherProfileView()
                }else{
                    self.setupStudentProfileView()
                }
    
//        guard let email = UsernameTxtField.text, UsernameTxtField.text?.count != 0 else {
//            self.showAlertFor(title: "Alert", message: "Please enter e-mail id")
//            return
//        }
//
//        if invalidEmail(emailId: email) == false{
//            self.showAlertFor(title: "Alert", message: "Please enter your valid e-mail id")
//            return
//        }
//
//        guard let password = PasswordTxtField.text, PasswordTxtField.text?.count != 0 else{
//            self.showAlertFor(title: "Alert", message: "Please enter your password")
//            return
//        }
  }

    @IBAction func SignupBtn(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let signup = story.instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
        self.present(signup, animated: true, completion: nil)
        
    }
    
//    func showAlertFor(title:String, message:String) -> Void {
//        let OKAction:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(OKAction)
//        self.present(alert, animated: true, completion: nil)
//    }
    
//    func invalidEmail(emailId: String)-> Bool{
//        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with:emailId)
//
//    }
    

    
    
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
    
    //MARK:- UITextField delegate methods
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
