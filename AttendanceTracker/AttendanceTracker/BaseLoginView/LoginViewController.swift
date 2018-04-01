//
//  ViewController.swift
//  LoginSignUpSwipe
//
//  Created by Alexej Nenastev on 03.05.17.
//  Copyright © 2017 Alexej Nenastev. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var sbs_height_constr: NSLayoutConstraint!
    @IBOutlet weak var sbs_horizontal_space_to_tongue: NSLayoutConstraint!
    @IBOutlet weak var sbs_y_center_constr: NSLayoutConstraint!
    @IBOutlet weak var socialButtonStack: UIStackView!
    @IBOutlet weak var logoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTongueConstraint: NSLayoutConstraint!
    @IBOutlet var textFields: [CustomTextField]!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var tongueView: TongueView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    let transition = JumpAnimator()
    
    private var bottomTongueConstraintInitValue: CGFloat!
    private var logoWidthConstraintInitValue: CGFloat!
    private var sbs_horizontal_space_to_tongue_init_val: CGFloat!
    private var sbs_y_center_constr_init_val: CGFloat!
    private var sbs_height_constr_init_val: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tongueView.tapAction = {
            let signUp = self.storyboard!.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            signUp.transitioningDelegate = self
          self.present(signUp, animated: true, completion: nil)
        
        }
        
        loginLabel.text = ""
        
        loginLabel.isHidden = true
        
        textFields.forEach { $0.delegate = self }
        loginLabel.layoutIfNeeded()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        view.addGestureRecognizer(tap)
                 
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        
        logoWidthConstraint.constant = view.frame.size.width / 4.0
        sbs_height_constr.constant = tongueView.bounds.size.height / 1.7
        
        bottomTongueConstraintInitValue = bottomTongueConstraint.constant
        logoWidthConstraintInitValue = logoWidthConstraint.constant
        sbs_horizontal_space_to_tongue_init_val = sbs_horizontal_space_to_tongue.constant
        sbs_y_center_constr_init_val = sbs_y_center_constr.constant
        sbs_height_constr_init_val = sbs_height_constr.constant
        
         
    }
 
    private lazy var tongueLabelOffset: CGFloat = { return self.tongueView.frame.height / 4.0}()
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        print("keyboardWillShow")
        let newConst = notification.getKeyboardHeight() - tongueView.bounds.midY
        guard bottomTongueConstraint.constant != newConst else {  return }
        
        let newLabelCenter = CGPoint(x: tongueView.label.center.x, y: tongueView.label.center.y - tongueLabelOffset)
        
        bottomTongueConstraint.constant = newConst
        logoWidthConstraint.constant = logoWidthConstraintInitValue / 2
        sbs_horizontal_space_to_tongue.constant = sbs_horizontal_space_to_tongue_init_val * 6
        sbs_y_center_constr.constant = sbs_y_center_constr.constant - tongueLabelOffset - 3
        sbs_height_constr.constant = tongueView.bounds.size.height / 2.5
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.view.layoutIfNeeded()
            self.tongueView.label.center = newLabelCenter
        })
       
    }
 
    @objc func keyboardWillHide(notification: NSNotification) {
        
        print("keyboardWillHide")
        guard bottomTongueConstraint.constant != bottomTongueConstraintInitValue else {  return }
         
        let newLabelCenter = CGPoint(x: tongueView.label.center.x, y: tongueView.label.center.y + tongueLabelOffset)
        
        
        bottomTongueConstraint.constant = bottomTongueConstraintInitValue
        logoWidthConstraint.constant = logoWidthConstraintInitValue
        sbs_horizontal_space_to_tongue.constant = sbs_horizontal_space_to_tongue_init_val
        sbs_y_center_constr.constant = sbs_y_center_constr_init_val
        sbs_height_constr.constant = sbs_height_constr_init_val
        UIView.animate(withDuration: 0.5,  animations: {
            
            self.view.layoutIfNeeded()
            self.tongueView.label.center = newLabelCenter
        })
    }
    
    
    @objc func dissmisKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @IBAction func onLoginBtnTapped(_ sender: Any) {
        setupYALTabBarController()
    }
    
    func setupYALTabBarController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "FoldingTabBarController") as? YALFoldingTabBarController
        
        
        let studentStoryBoard = UIStoryboard(name: "StudentProfileMain", bundle: nil)
        let controller = studentStoryBoard.instantiateInitialViewController()
        
       self.present(controller!, animated: true, completion: nil)

        
        
      /*  let item1 = YALTabBarItem(itemImage: UIImage(named: "nearby_icon"), leftItemImage: nil, rightItemImage: nil)
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
 
 
        
    */
    }
}


extension LoginViewController: TongueSwipeController {

    var tongue: TongueView { return self.tongueView }
    var nameLabel : UILabel { return self.loginLabel }
    var socialButtonsView : UIStackView { return self.socialButtonStack }
}

extension LoginViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
        ) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
    }
}
