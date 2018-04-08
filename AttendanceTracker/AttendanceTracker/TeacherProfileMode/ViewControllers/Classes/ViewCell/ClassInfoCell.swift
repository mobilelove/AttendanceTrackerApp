//
//  ClassInfoCell.swift
//  AttendanceTracker
//
//  Created by Veerachamy, Vimal on 4/8/18.
//  Copyright © 2018 Lavanya. All rights reserved.
//

import UIKit

class ClassInfoCell: UITableViewCell {
    
    @IBOutlet var nameLbl:UILabel?
    @IBOutlet var idLbl:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellWith(name:String, idValue:String) -> Void {
        
        self.nameLbl?.text = name
        self.idLbl?.text = "Course Code: \(idValue)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
