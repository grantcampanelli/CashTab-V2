//
//  Transaction.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/15/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import UIKit

struct Transaction {
    var title: String?
    var cost: String?
    var category: String?
    
    init(title: String?, cost: String?, category: String?) {
        self.title = title
        self.cost = cost
        self.category = category
    }
}
