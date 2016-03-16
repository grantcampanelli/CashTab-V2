//
//  TransactionModel.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/15/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import Foundation
import RealmSwift

class TModel: Object {
    dynamic var vendor: String?
    dynamic var cost: String?
    dynamic var category: String?
    dynamic var date: NSDate?
    dynamic var paymentMethod: String?
    dynamic var location: String?
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
