//
//  SpecificTransactionsVC.swift
//  CashTab-V2
//
//  Created by Grant Campanelli on 3/15/16.
//  Copyright © 2016 Grant Campanelli. All rights reserved.
//

import UIKit
import RealmSwift

class SpecificTransactionsVC: UITableViewController {

    var category: String?
    let realm = try! Realm()
    var transactionsByCat = try! Realm().objects(TModel).sorted("vendor")
   // let realm = try! Realm()
    //let array =

   //@IBOutlet weak var vendorLabel: UILabel!
    //@IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var categoryPageTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cat = self.category
        print(cat)
        let predicate = NSPredicate(format: "category == %@", cat!)
        transactionsByCat = transactionsByCat.filter(predicate)
        print(transactionsByCat)
        //let cats = try Realm().objects(TModel).filter("category == 'Food'")
        //self.tByCat = cats
        self.navigationItem.title = cat
        setupTotalCostLabel()
        
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transactionsByCat.count
    }

    @IBOutlet weak var totalByCategory: UILabel!
    
    func setupTotalCostLabel() {
        var total = 0.0
        for t in self.transactionsByCat {
            let num = NSNumberFormatter().numberFromString(t.cost!);
            total += (num?.doubleValue)!
        }
        totalByCategory.text! = "$"  + (NSString(format:"%.2f", total) as String)
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tByCategory", forIndexPath: indexPath)
        cell.textLabel!.text = self.transactionsByCat[indexPath.row].vendor

        let ns = NSNumberFormatter().numberFromString(self.transactionsByCat[indexPath.row].cost!);
        let num = ns?.doubleValue
        cell.detailTextLabel!.text = "$" + (NSString(format:"%.2f", num!) as String)


        return cell
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
