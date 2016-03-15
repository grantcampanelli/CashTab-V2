//
//  AddTransactionTableViewController.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/15/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import UIKit

class AddTransactionTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var costTextField: UITextField!

    @IBOutlet weak var category: UILabel!
    
    var transaction: Transaction?
    
    var categoryVar:String = "Miscellaneous" {
        didSet {
            category.text? = categoryVar
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveTransactionDetail" {
            transaction = Transaction(title: titleTextField.text, cost: costTextField.text, category: categoryVar)
        }
    }
    
    @IBAction func unwindWithSelectedCategory(segue:UIStoryboardSegue) {
        if let categoryPickerViewController = segue.sourceViewController as? CategoryPickerViewController,
            selectedCategory = categoryPickerViewController.selectedCategory {
                categoryVar = selectedCategory
        }
    }
    
//    let context = self.fetchedResultsController.managedObjectContext
//    let entity = self.fetchedResultsController.fetchRequest.entity!
//    let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
//    
//    // If appropriate, configure the new managed object.
//    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//    newManagedObject.setValue(title, forKey: "title")
//    newManagedObject.setValue(cost, forKey: "cost")
//    
//    // Save the context.
//    do {
//    try context.save()
//    } catch {
//    // Replace this implementation with code to handle the error appropriately.
//    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//    //print("Unresolved error \(error), \(error.userInfo)")
//    abort()
//    }
}
