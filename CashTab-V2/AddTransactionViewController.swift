//
//  AddTransactionViewController.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/10/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import Foundation
import UIKit

class AddTranscationViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    
}