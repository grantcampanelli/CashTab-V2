//
//  DetailViewController.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/10/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import CoreData
import UIKit
import RealmSwift

class TransactionDetailViewController: UITableViewController {

   
    
    var detailItemIndex: Int?
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
         //Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let vendor = self.transactionTitleLabel {
                vendor.text = detail.valueForKey("vendor")!.description
            }
            if let cost = self.transactionCostLabel {
                let ns = NSNumberFormatter().numberFromString(detail.valueForKey("cost")!.description);
                let num = ns?.doubleValue
                cost.text = "$" + (NSString(format:"%.2f", num!) as String)

                //cost.text = "$" + detail.valueForKey("cost")!.description
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
        //let detail = self.detailItem as! NSManagedObject
        
        if(self.detailItem != nil && (self.detailItem!.valueForKey("category")!.description != newCategory)){
            
            let realm = try! Realm()
            let transactionObjects = realm.objects(TModel).sorted("vendor")
            //transactionObjects[detailItemIndex!].category = newCategory
            
            try! realm.write {
                transactionObjects[detailItemIndex!].setValue(newCategory, forKeyPath: "category")
                //realm.create(TModel.self, value: ["category": newCategory], update: true)
                // the book's `title` property will remain unchanged.
            }
            
//            detail.setValue(newCategory, forKey: "category")
//            
//            // Save the context.®
//            do {
//                try detail.managedObjectContext?.save()
//            } catch {
//                abort()
//            }

        }
        
    }

}

