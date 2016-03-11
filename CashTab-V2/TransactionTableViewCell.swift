//
//  TransactionTableViewCell.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/10/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
