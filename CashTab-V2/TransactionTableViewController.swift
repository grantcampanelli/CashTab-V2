//
//  MasterViewController.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/10/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

//// Custom UITableViewCell allowing for customized prototype cells (Configureable in Storyboard)
//class TransactionViewCell: UITableViewCell {
//    @IBOutlet weak var title: UILabel!
//    @IBOutlet weak var cost: UILabel!
//    var test: String?
//    
//    var thisTransaction: NSManagedObject?
//}


class TransactionTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    //let realm = try! Realm()
    let realm = try! Realm()
    //var transactionObjects = try! Realm().objects(TModel)
    var transactionObjects = try! Realm().objects(TModel).sorted("vendor")
    
    var detailViewController: TransactionDetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil

    @IBOutlet weak var totalTransactionCost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transactionObjects = try! Realm().objects(TModel).sorted("vendor")
         setupTotalCostLabel()
        
       
//        for t in realm.objects(TModel).filter(predicate) {
//            
//        }
//        //print(total)
//        //let str = NSNumberFormatter().stringFromNumber(total)
//        
//        
//        cell.textLabel?.text = cat;
//        cell.detailTextLabel?.text = "$"  + (NSString(format:"%.2f", total) as String)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
       // let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addTransaction:")
        //self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? TransactionDetailViewController
        }
        testRealm()
    }
    func setupTotalCostLabel() {
        var total = 0.0
        for t in self.transactionObjects {
            let num = NSNumberFormatter().numberFromString(t.cost!);
            total += (num?.doubleValue)!
        }
        totalTransactionCost.text! = "$"  + (NSString(format:"%.2f", total) as String)

    }

    func testRealm() {
        let categoryObjects = try! Realm().objects(CModel).sorted("name")
        print(categoryObjects)
        let transactionObjects = try! Realm().objects(TModel).sorted("vendor")
        print(transactionObjects)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(sender: AnyObject) {
//        let context = self.fetchedResultsController.managedObjectContext
//        let entity = self.fetchedResultsController.fetchRequest.entity!
//        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
//             
//        // If appropriate, configure the new managed object.
//        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//        newManagedObject.setValue("Clicked AGAIN", forKey: "title")
//             
//        // Save the context.
//        do {
//            try context.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            //print("Unresolved error \(error), \(error.userInfo)")
//            abort()
//        }
//    }
//    
//    func insertNewTransaction(title: String, cost: String) {
//        let context = self.fetchedResultsController.managedObjectContext
//        let entity = self.fetchedResultsController.fetchRequest.entity!
//        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
//        
//        // If appropriate, configure the new managed object.
//        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//        newManagedObject.setValue(title, forKey: "title")
//        newManagedObject.setValue(cost, forKey: "cost")
//        
//        // Save the context.
//        do {
//            try context.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            //print("Unresolved error \(error), \(error.userInfo)")
//            abort()
//        }
//    }
    
/*
    @IBAction func addNewTransactionButton(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Transaction", message: "Add a new transaction", preferredStyle: .Alert)
        
         Setting up Save Action
         Takes whatever text is in the textfield and puts it into the Transactions array
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                let transactionTitle = alert.textFields![0]
                let transactionCost = alert.textFields![1]
                self.insertNewTransaction(transactionTitle.text!, cost: transactionCost.text!);
                self.saveTransaction(transactionTitle.text!, cost: transactionCost.text!)
                self.reloadData()
        })
        
         Setting up Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction) -> Void in
        }
        
         Configure the alert controller - Add a textfield in the alert
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
         Add another textfield in the alert
        alert.addTextFieldWithConfigurationHandler {
            (transactionCost: UITextField) -> Void in
            transactionCost.placeholder = "$1.99"
        }
        
        
         Add the "Save" and "Cancel" actions to the alert controller
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
         Display the Alert View Controller on-screen
        presentViewController(alert, animated: true, completion: nil)
    }
    */


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! TransactionDetailViewController
                controller.detailItem = transactionObjects[indexPath.row]
                controller.detailItemIndex = indexPath.row
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
        
        //return self.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 5;
        //let sectionInfo = self.fetchedResultsController.sections![section]
        return self.transactionObjects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TransactionTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TransactionTableViewCell
        
        //cell.test
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let t = realm.objects(TModel).sorted("vendor")
            let r = t[indexPath.row]
            try! realm.write {
                realm.delete(r)
            }
            //self.transactionObjects = try! Realm().objects(TModel).sorted("vendor")
            tableView.reloadData()
            setupTotalCostLabel()
//
//            let context = self.fetchedResultsController.managedObjectContext
//            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
//                
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                //print("Unresolved error \(error), \(error.userInfo)")
//                abort()
//            }
        }
    }

    func configureCell(cell: TransactionTableViewCell, atIndexPath indexPath: NSIndexPath) {
        //let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
        
        cell.textLabel!.text = self.transactionObjects[indexPath.row].vendor //object.valueForKey("title")!.description as String
        let ns = NSNumberFormatter().numberFromString(self.transactionObjects[indexPath.row].cost!);
        let num = ns?.doubleValue
        cell.detailTextLabel!.text = "$" + (NSString(format:"%.2f", num!) as String)
        
        
        //cell.detailTextLabel!.text = self.transactionObjects[indexPath.row].cost //object.valueForKey("cost")!.description as String
        //cell.titleLabel.text = "Test";
        //cell.costLabel.text = "Cost";
        
    }

    // MARK: - Fetched results controller

//    var fetchedResultsController: NSFetchedResultsController {
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
//        
//        let fetchRequest = NSFetchRequest()
//        // Edit the entity name as appropriate.
//        let entity = NSEntityDescription.entityForName("Transaction", inManagedObjectContext: self.managedObjectContext!)
//        fetchRequest.entity = entity
//        
//        // Set the batch size to a suitable number.
//        fetchRequest.fetchBatchSize = 20
//        
//        // Edit the sort key as appropriate.
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
//        
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        // Edit the section name key path and cache name if appropriate.
//        // nil for section name key path means "no sections".
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
//        aFetchedResultsController.delegate = self
//        _fetchedResultsController = aFetchedResultsController
//        
//        do {
//            try _fetchedResultsController!.performFetch()
//        } catch {
//             // Replace this implementation with code to handle the error appropriately.
//             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//             //print("Unresolved error \(error), \(error.userInfo)")
//             abort()
//        }
//        
//        return _fetchedResultsController!
//    }    
//    var _fetchedResultsController: NSFetchedResultsController? = nil
//
//    func controllerWillChangeContent(controller: NSFetchedResultsController) {
//        self.tableView.beginUpdates()
//    }
//
//    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
//        switch type {
//            case .Insert:
//                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
//            case .Delete:
//                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
//            default:
//                return
//        }
//    }
//
//    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//        switch type {
//            case .Insert:
//                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
//            case .Delete:
//                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
//            case .Update:
//                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)! as! TransactionTableViewCell, atIndexPath: indexPath!)
//            case .Move:
//                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
//                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
//        }
//    }
//
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        self.tableView.endUpdates()
//    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

    
    
    /* Save transcation code */
//    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
//    }
    
    @IBAction func saveTransaction(segue:UIStoryboardSegue) {
        if let addTransactionViewController = segue.sourceViewController as? AddTransactionTableViewController {
            
            //add the new player to the players array
            if let transaction = addTransactionViewController.transaction {
//                let context = self.fetchedResultsController.managedObjectContext
//                let entity = self.fetchedResultsController.fetchRequest.entity!
//                let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
                
                let newTransaction = TModel()
                newTransaction.vendor = transaction.vendor
                newTransaction.cost = transaction.cost
                newTransaction.category = transaction.category
                newTransaction.date = transaction.date
                newTransaction.paymentMethod = transaction.paymentMethod
                newTransaction.location = "N/A"
                try! realm.write {
                    realm.add(newTransaction)
                }
                self.transactionObjects = try! Realm().objects(TModel).sorted("vendor")
                tableView.reloadData()
                NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
                setupTotalCostLabel()
                testRealm()
                //realm.beginWrite()
                //realm.create(TModel.self, value: )
                
                //try! realm.commitWrite()

                // If appropriate, configure the new managed object.
                // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//                newManagedObject.setValue(transaction.title, forKey: "title")
//                 newManagedObject.setValue(transaction.cost, forKey: "cost")
//                 newManagedObject.setValue(transaction.category, forKey: "category")
//                newManagedObject.setValue(transaction.date, forKey: "date")
//                newManagedObject.setValue(transaction.paymentMethod, forKey: "paymentMethod")
//                
//                // Save the context.
//                do {
//                    try context.save()
//                } catch {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    //print("Unresolved error \(error), \(error.userInfo)")
//                    abort()
//                }

                
//                players.append(player)
//                
//                //update the tableView
                //let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
                //tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
}

