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
    
    
    
//
////            var imageCropVC : RSKImageCropViewController!
////
////            imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.Circle)
////
////            imageCropVC.delegate = self
////
////            self.navigationController?.pushViewController(imageCropVC, animated: true)
//
//
//
//      self.dismiss(animated: true, completion: nil)


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

    
    
    
    @IBAction func LoginBtn(_ sender: Any) {
    
        let loginstory = UIStoryboard(name: "SampleMenuViewController", bundle: nil)
        let login = loginstory.instantiateViewController(withIdentifier: "studentMenu")
        self.present(login, animated: true, completion: nil)
    
        }
    
    @IBAction func SignupBtn(_ sender: Any) {
         let story = UIStoryboard(name: "Main", bundle: nil)
        let signup = story.instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
        self.present(signup, animated: true, completion: nil)
       
      }
    
    
 }
