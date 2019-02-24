//
//  GroupsTableViewCell.swift
//  SmartListIOS
//
//  Created by admin on 06/02/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameTextField: UILabel!
    @IBOutlet weak var groupDescriptionTextField: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    
    public var id:String=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
