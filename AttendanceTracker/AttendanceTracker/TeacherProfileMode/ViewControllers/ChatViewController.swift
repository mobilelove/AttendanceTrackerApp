//
//  ChatViewController.swift
//  Example-Swift
//
//  Created by Serhii Butenko on 29/8/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

private let ChatDemoImageName = "imageName"
private let DemoUserName = "userName"
private let ChatDemoMessageText = "messageText"
private let ChatDemeDateText = "dateText"

private let reuseIdentifier = "ChatCollectionViewCell"

class ChatViewController: UIViewController {
  
  typealias Message = [String: String]
  
  fileprivate var messages: [Message] = []
  fileprivate let cellAnumationDuration: Double = 0.25
  fileprivate let animationDelayStep: Double = 0.1
    
    
    
    
    fileprivate var broadcasting: Bool = false
    fileprivate var beacon: CLBeaconRegion?
    fileprivate var peripheralManager: CBPeripheralManager?
    
    
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  //MARK: - View & VC life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    messages = NSArray(contentsOfFile: Bundle.main.path(forResource: "YALChatDemoList", ofType: "plist")!) as! [Message]
    
    
    
    let UUID: UUID = iBeaconConfiguration.uuid
    
    let major: CLBeaconMajorValue = CLBeaconMajorValue(arc4random() % 100 + 1)
    let minor: CLBeaconMinorValue = CLBeaconMinorValue(arc4random() % 2 + 1)
    
    self.beacon = CLBeaconRegion(proximityUUID: UUID, major: major, minor: minor, identifier: "tw.darktt.beaconDemo")
    
    self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    prepareVisibleCellsForAnimation()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    animateVisibleCells()
  }
    
    deinit
    {
        self.beacon = nil
        self.peripheralManager = nil
    }
  
}

extension ChatViewController
{
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        if self.broadcasting {
            return .lightContent
        }
        
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation
    {
        return .fade
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return false
    }
}

extension ChatViewController
    {
        @IBAction fileprivate func broadcastBeacon(sender: UIButton) -> Void
        {
            let state: CBManagerState = self.peripheralManager!.state
            
            if (state == .poweredOff && !self.broadcasting) {
                let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                let alert: UIAlertController = UIAlertController(title: "Bluetooth OFF", message: "Please power on your Bluetooth!", preferredStyle: .alert)
                alert.addAction(OKAction)
                
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            let titleFromStatus: (Void) -> String = {
                let title: String = (self.broadcasting) ? "Start" : "Stop"
                
                return title + " Broadcast"
            }
            
            //        let buttonTitleColor: UIColor = (self.broadcasting) ? UIColor.iOS7BlueColor() : UIColor.iOS7WhiteColor()
            
            //sender.setTitle(titleFromStatus(), for: UIControlState.normal)
            //  sender.setTitleColor(buttonTitleColor, for: UIControlState.normal)
            
            let labelTextFromStatus: (Void) -> String = {
                let text: String = (self.broadcasting) ? "Not Broadcast" : "Broadcasting..."
                
                return text
            }
            
            //        self.statusLabel.text = labelTextFromStatus(<#Void#>)
            
            let animations: () -> Void = {
                //    let backgroundColor: UIColor = (self.broadcasting) ? UIColor.iOS7WhiteColor() : UIColor.iOS7BlueColor()
                
                //            self.view.backgroundColor = backgroundColor
                
                self.broadcasting = !self.broadcasting
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
            let completion: (Bool) -> Void = {
                finish in
                self.advertising(start: self.broadcasting)
            }
            
            UIView.animate(withDuration: 0.25, animations: animations, completion: completion)
        }
        
        // MARK: - Broadcast Beacon
        
        func advertising(start: Bool) -> Void
        {
            if self.peripheralManager == nil {
                return
            }
            
            if (!start) {
                self.peripheralManager!.stopAdvertising()
                
                return
            }
            
            let state: CBManagerState = self.peripheralManager!.state
            
            if (state == .poweredOn) {
                let UUID:UUID = (self.beacon?.proximityUUID)!
                let serviceUUIDs: Array<CBUUID> = [CBUUID(nsuuid: UUID)]
                
                // Why NSMutableDictionary can not convert to Dictionary<String, Any> 😂
                var peripheralData: Dictionary<String, Any> = self.beacon!.peripheralData(withMeasuredPower: 1)  as NSDictionary as! Dictionary<String, Any>
                peripheralData[CBAdvertisementDataLocalNameKey] = "iBeacon Demo"
                peripheralData[CBAdvertisementDataServiceUUIDsKey] = serviceUUIDs
                
                self.peripheralManager!.startAdvertising(peripheralData)
            }
        }
}

// MARK: - CBPeripheralManager Delegate -

extension ChatViewController: CBPeripheralManagerDelegate
{
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager)
    {
        let state: CBManagerState = peripheralManager!.state
        
        if state == .poweredOff {
           // self.statusLabel.text = "Bluetooth Off"
            
            if self.broadcasting {
              //  self.broadcastBeacon(sender: self.triggerButton)
            }
        }
        
        if state == .unsupported {
           // self.statusLabel.text = "Unsupported Beacon"
        }
        
        if state == .poweredOn {
          //  self.statusLabel.text = "Not Broadcast"
        }
    }
}

extension ChatViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCollectionViewCell
    
    let message = messages[(indexPath as NSIndexPath).row]
    
    cell.configure(
      withImage: UIImage(named: message[ChatDemoImageName]!)!,
      userName: message[DemoUserName]!,
      messageText: message[ChatDemoMessageText]!,
      dateText: message[ChatDemeDateText]!
    )
    
    return cell
  }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    return CGSize(width: view.bounds.width, height: layout.itemSize.height)
  }
}

extension ChatViewController {
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segue.destination.hidesBottomBarWhenPushed = true
  }
}

//MARK: - Cell's animation

private extension ChatViewController {
  
  func prepareVisibleCellsForAnimation() {
    collectionView.visibleCells.forEach {
      $0.frame = CGRect(
        x: -$0.bounds.width,
        y: $0.frame.origin.y,
        width: $0.bounds.width,
        height: $0.bounds.height
      )
      $0.alpha = 0
    }
  }
  
  func animateVisibleCells() {
    collectionView.visibleCells.enumerated().forEach { offset, cell in
      cell.alpha = 1
      UIView.animate(
        withDuration: self.cellAnumationDuration,
        delay: Double(offset) * self.animationDelayStep,
        options: .curveEaseOut,
        animations: {
          cell.frame = CGRect(
            x: 0,
            y: cell.frame.origin.y,
            width: cell.bounds.width,
            height: cell.bounds.height
          )
      })
    }
  }
  
}
