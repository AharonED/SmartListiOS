//
//  ChecklistsTableViewCell.swift
//  SmartListIOS
//
//  Created by admin on 03/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class ChecklistsTableViewCell: UITableViewCell {

    @IBOutlet weak var ChecklistNameTextField: UILabel!
    
    @IBOutlet weak var ChecklistDescTextField: UILabel!
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
