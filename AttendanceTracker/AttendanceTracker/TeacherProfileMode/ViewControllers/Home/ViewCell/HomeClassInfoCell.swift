//
//  HomeClassInfoCell.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/7/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit

class HomeClassInfoCell: UITableViewCell {
    
    @IBOutlet var classNameLbl : UILabel?
    @IBOutlet var classIDLbl:UILabel?
    @IBOutlet var classTimeLbl : UILabel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureClassInfoCellWith(name:String, id:String, time:String) -> Void {
        self.classNameLbl?.text = name
        self.classIDLbl?.text = "Course ID : \(id)"
        self.classTimeLbl?.text = time
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
