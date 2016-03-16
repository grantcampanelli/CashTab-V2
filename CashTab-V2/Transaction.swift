//
//  Transaction.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/15/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import UIKit
import CoreData

struct Transaction {
    var vendor: String?
    var cost: String?
    var category: String?
    var date: NSDate?
    var paymentMethod: String?
    
    init(vendor: String?, cost: String?, category: String?,
        date: NSDate?, paymentMethod: String?) {
        self.vendor = vendor
        self.cost = cost
        self.category = category
        self.date = date
        self.paymentMethod = paymentMethod
    }
}
