//
//  AddTransactionViewController.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/10/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import Foundation
import UIKit
import DropDown

class AddTranscationViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var categories = ["Food", "Fitness", "Shopping", "Business", "Reimbursable", "Miscellaneous"];

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categories[row]
    }
    
}