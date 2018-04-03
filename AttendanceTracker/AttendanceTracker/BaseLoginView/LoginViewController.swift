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

   @IBOutlet weak var LoginImgView: UIImageView!
    
    @IBOutlet weak var UsernameTxtField: CustomTextField!
    
    
    @IBOutlet weak var PasswordTxtField: CustomTextField!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        UsernameTxtField.delegate = self
        PasswordTxtField.delegate = self
         LoginImgView.layer.cornerRadius = LoginImgView.frame.size.width/2
         LoginImgView.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
    }
    
    
    
         @IBAction func EditBtnImg(_ sender: Any) {
    
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true, completion: nil)
    
      }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
          LoginImgView.image = image
        }
        else{
            
        }
//            self.dismiss(animated: false, completion: nil)
//
//            var imageCropVC : RSKImageCropViewController!
//
//            imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.Circle)
//
//            imageCropVC.delegate = self
//
//            self.navigationController?.pushViewController(imageCropVC, animated: true)

        
        
      self.dismiss(animated: true, completion: nil)
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
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
    }
 
    @objc func keyboardWillHide(notification: NSNotification) {
    
    }
    

    
    @IBAction func onLoginBtnTapped(_ sender: Any) {
        setupYALTabBarController()
    }
    
    func setupYALTabBarController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "FoldingTabBarController") as? YALFoldingTabBarController
        
        
        let studentStoryBoard = UIStoryboard(name: "StudentProfileMain", bundle: nil)
        let controller = studentStoryBoard.instantiateInitialViewController()
        
      //self.present(controller!, animated: true, completion: nil)


        
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
    
 }
