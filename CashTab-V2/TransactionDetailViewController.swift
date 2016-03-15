//
//  DetailViewController.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/10/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import CoreData
import UIKit

class TransactionDetailViewController: UITableViewController {

   

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
         //Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let title = self.transactionTitleLabel {
                title.text = detail.valueForKey("title")!.description
            }
            if let cost = self.transactionCostLabel {
                cost.text = detail.valueForKey("cost")!.description
            }
            if let date = self.transactionDateLabel {
                let newDate = detail.valueForKey("date") as! NSDate
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
                dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
                date.text = dateFormatter.stringFromDate(newDate)
            }
            if let payment = self.transactionPaymentLabel {
                payment.text = detail.valueForKey("paymentMethod")!.description
            }
            if let category = self.transactionCategoryLabel {
                self.categoryVar = detail.valueForKey("category")!.description
                category.text = self.categoryVar
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var categoryVar:String? {
        didSet {
            transactionCategoryLabel.text? = categoryVar!
        }
    }

    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionTitleLabel: UILabel!
    @IBOutlet weak var transactionCostLabel: UILabel!
    @IBOutlet weak var transactionCategoryLabel: UILabel!
    @IBOutlet weak var transactionPaymentLabel: UILabel!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdateCategory" {
            if let categoryPickerViewController = segue.destinationViewController as? CategoryPickerViewController {
                categoryPickerViewController.selectedCategory = categoryVar
            }
        }
    }
    
    @IBAction func unwindWithSelectedCategory(segue:UIStoryboardSegue) {
        if let categoryPickerViewController = segue.sourceViewController as? CategoryPickerViewController,
            selectedCategory = categoryPickerViewController.selectedCategory {
                categoryVar = selectedCategory
                updateItemCategory(selectedCategory)
        }
    }
    
    func updateItemCategory(newCategory: String) {
        let detail = self.detailItem as! NSManagedObject
        
        if(detail.valueForKey("category")!.description != newCategory) {
            detail.setValue(newCategory, forKey: "category")
            
            // Save the context.®
            do {
                try detail.managedObjectContext?.save()
            } catch {
                abort()
            }

        }
        
    }

}

