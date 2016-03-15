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
        setupDatePicker()
        initTodaysDate()
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
    
    
    @IBOutlet weak var paymentMethodTextField: UILabel!

    
    var transaction: Transaction?
    
    var categoryVar:String = "Miscellaneous" {
        didSet {
            category.text? = categoryVar
        }
    }
    
    var paymentVar:String = "Cash" {
        didSet {
            paymentMethodTextField.text? = paymentVar
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveTransactionDetail" {
            transaction = Transaction(title: titleTextField.text, cost: costTextField.text, category: categoryVar, date: dateVar, paymentMethod: paymentVar);
        }
        if segue.identifier == "PickCategory" {
            if let categoryPickerViewController = segue.destinationViewController as? CategoryPickerViewController {
                categoryPickerViewController.selectedCategory = categoryVar
            }
        }
        if segue.identifier == "PickPaymentMethod" {
            if let paymentPickerViewController = segue.destinationViewController as? PaymentMethodPickerVC {
                paymentPickerViewController.selectedPayment = paymentVar
            }
        }

    }
    
    @IBAction func unwindWithSelectedCategory(segue:UIStoryboardSegue) {
        if let categoryPickerViewController = segue.sourceViewController as? CategoryPickerViewController,
            selectedCategory = categoryPickerViewController.selectedCategory {
                categoryVar = selectedCategory
        }
    }
    
    @IBAction func unwindWithSelectedPayment(segue:UIStoryboardSegue) {
        if let paymentPickerViewController = segue.sourceViewController as? PaymentMethodPickerVC,
            selectedPayment = paymentPickerViewController.selectedPayment {
                paymentVar = selectedPayment
        }
    }
    
    
    @IBOutlet weak var dateTextField: UITextField!
    var dateVar: NSDate?
    
    func setupDatePicker() {
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.BlackTranslucent
        
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.backgroundColor = UIColor.blackColor()
        
        
        let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.Plain, target: self, action: "tappedToolBarBtn:")
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "donePressed:")
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.text = "Select a due date"
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        dateTextField.inputAccessoryView = toolBar
        
    }
    
    
    func donePressed(sender: UIBarButtonItem) {
        
        dateTextField.resignFirstResponder()
        
    }
    
    func initTodaysDate() {
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateformatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dateVar = NSDate();
        dateTextField.text = dateformatter.stringFromDate(NSDate())
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateformatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dateVar = NSDate();
        dateTextField.text = dateformatter.stringFromDate(NSDate())
        
        dateTextField.resignFirstResponder()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dateVar = sender.date
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
        
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
