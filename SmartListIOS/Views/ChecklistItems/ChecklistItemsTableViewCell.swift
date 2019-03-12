//
//  ChecklistItemsTableViewCell.swift
//  SmartListIOS
//
//  Created by admin on 12/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class ChecklistItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var ChecklistItemNameTextField: UILabel!
    @IBOutlet weak var ChecklistItemDescTextField: UILabel!
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
