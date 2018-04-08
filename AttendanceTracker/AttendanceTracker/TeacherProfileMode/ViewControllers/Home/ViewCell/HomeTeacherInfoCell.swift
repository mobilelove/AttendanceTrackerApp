//
//  HomeTeacherInfoCell.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/7/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit

class HomeTeacherInfoCell: UITableViewCell {
    
    @IBOutlet var teacherImgView : UIImageView?
    @IBOutlet var teacherNameLbl : UILabel?
    @IBOutlet var teacherIDLbl : UILabel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureTeacherCellWith(imageName: String, name: String, id:String) -> Void {
        
        self.teacherImgView?.image = UIImage(named: imageName)
        self.teacherNameLbl?.text = name
        self.teacherIDLbl?.text = "ID: \(id)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
