//
//  TransactionsByCategoryVC.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/15/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TransactionsByCategoryVC: UITableViewController, NSFetchedResultsControllerDelegate {
    let realm = try! Realm()
    //let categoryObjects = try! Realm().objects(CModel).sorted("name")
    var categories = ["Food", "Fitness", "Shopping", "Business", "Reimbursable", "Miscellaneous"];
    var managedObjectContext: NSManagedObjectContext? = nil
    var transactionsByCat = try! Realm().objects(TModel).sorted("vendor")
    
//    private var tb: UITableView?
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.transactionsByCat = try! Realm().objects(TModel).sorted("vendor")
//        
//        tb?.reloadData()   // ...and it is also visible here.
//    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableData:", name: "reload", object: nil)
        super.viewDidLoad()
        //fetchAllTransactions()
        //self.managedObjectContext
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func reloadTableData(notification: NSNotification) {
        tableView.reloadData()
    }
    
//    func fetchAllTransactions() {
////        // Initialize Fetch Request
//        let fetchRequest = NSFetchRequest()
//        
//        // Create Entity Description
//        let entity = NSEntityDescription.entityForName("Transaction", inManagedObjectContext: self.managedObjectContext!)
//        fetchRequest.entity = entity
//        
//        // Configure Fetch Request
//        
//        do {
//            let result = try self.managedObjectContext!.executeFetchRequest(fetchRequest)
//            print(result)
//            
//        } catch {
//            let fetchError = error as NSError
//            print(fetchError)
//        }
//    }
    
//    
//    @IBAction func addCategory(sender: AnyObject) {
//        
//        let alert = UIAlertController(title: "New Category", message: "Add a new category", preferredStyle: .Alert)
//        
//        //Setting up Save Action
//        //Takes whatever text is in the textfield and puts it into the Transactions array
//        let saveAction = UIAlertAction(title: "Save",
//            style: .Default,
//            handler: { (action:UIAlertAction) -> Void in
//                let categoryName = alert.textFields![0]
//                //let transactionCost = alert.textFields![1]
//                self.addCategoryToRealm(categoryName.text!)
//                //self.reloadData()
//                
//        })
//        
//        //Setting up Cancel Action
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
//            (action: UIAlertAction) -> Void in
//        }
//        
//        //Configure the alert controller - Add a textfield in the alert
//        alert.addTextFieldWithConfigurationHandler {
//            (textField: UITextField) -> Void in
//        }
//        
//        
//       // Add the "Save" and "Cancel" actions to the alert controller
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//        
//        //Display the Alert View Controller on-screen
//        presentViewController(alert, animated: true, completion: nil)
//    }
//    
//    func addCategoryToRealm(categoryName : String) {
//        realm.beginWrite()
//        realm.create(CModel.self, value: ["name": categoryName])
//        try! realm.commitWrite()
//        print(realm.objects(CModel))
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Category", forIndexPath: indexPath)
        let cat = categories[indexPath.row]
        let predicate = NSPredicate(format: "category == %@", cat)
        //let catTransactions = transactionsByCat.filter(predicate)
        var total = 0.0
        for t in realm.objects(TModel).filter(predicate) {
            let num = NSNumberFormatter().numberFromString(t.cost!);
            total += (num?.doubleValue)!
        }
        //print(total)
        //let str = NSNumberFormatter().stringFromNumber(total)

        
        cell.textLabel?.text = cat;
        cell.detailTextLabel?.text = "$"  + (NSString(format:"%.2f", total) as String)
        // Configure the cell...
       
        return cell

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowTransactionsByCategory" {
            if let indexPath = self.tableView.indexPathForSelectedRow?.row {
                let controller = segue.destinationViewController as! SpecificTransactionsVC
                controller.category = categories[indexPath];
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
    }

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

    
}
