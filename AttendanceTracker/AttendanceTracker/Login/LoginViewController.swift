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
    @IBOutlet weak var usernameTxtField: CustomTextField!
    @IBOutlet weak var passwordTxtField: CustomTextField!
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTxtField.delegate = self
        self.passwordTxtField.delegate = self
    }
    
    //MARK: - IBActions methods
    @IBAction func LoginBtn(_ sender: Any) {
        
     //  self.setupTeacherProfileView()

       self.setupStudentProfileView()
        
              /*  if(self.UsernameTxtField.text == "teacher"){
                    self.setupTeacherProfileView()
                }else{
                    self.setupStudentProfileView()
                }*/
    
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
    
    @IBAction func signUpAction(_ sender: Any) {
        
        self.showAlertFor(title: "Alert", message: "Sign Up feature in progress")
    }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        self.showAlertFor(title: "Alert", message: "Forgot Password feature in progress")
    }
    
    func showAlertFor(title:String, message:String) -> Void {
        let OKAction:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
//    func invalidEmail(emailId: String)-> Bool{
//        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with:emailId)
//
//    }

    func setupTeacherProfileView() -> Void {
        
        let storyboard = UIStoryboard(name: "TeacherMain", bundle: nil)
        let teacherTabbarController = storyboard.instantiateInitialViewController()
        self.present(teacherTabbarController!, animated: true, completion: nil)
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
        
        if textField == usernameTxtField
        {
            passwordTxtField.becomeFirstResponder()
            
        }else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
}
