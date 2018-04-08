//
//  StudentInfoCell.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/7/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit

class StudentInfoCell: UITableViewCell {
    
    @IBOutlet var studImageView: UIImageView?
    @IBOutlet var studNameLbl: UILabel?
    @IBOutlet var studIDLbl : UILabel?
    @IBOutlet var statusImgView : UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureStudentInfoCellWith(imageName:String, name:String, id:String, status:Bool) -> Void {
        
        self.studImageView?.image = UIImage(named: imageName)
        self.studNameLbl?.text = name
        self.studIDLbl?.text = "ID: \(id)"
        
        if status == false {
            self.statusImgView?.image = UIImage(named: "Uncheck")
        }else{
            self.statusImgView?.image = UIImage(named: "Check")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
