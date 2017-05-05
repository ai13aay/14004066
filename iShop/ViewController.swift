//
//  ViewController.swift
//  iShop
//
//  Created by ai13aay on 01/05/2017.
//  Copyright © 2017 ai13aay. All rights reserved.
//

import UIKit
var list = [String]()
var item = [String]()

var saveState = NSUserDefaults.standardUserDefaults()
var selected = String()


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let h = UIScreen.mainScreen().bounds.height
    let w = UIScreen.mainScreen().bounds.width
    var selected2 = -100
    var selected3 = String()
    
    
    @IBOutlet weak var createListLabel: UIButton!
    
    @IBOutlet weak var toastLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var bottomBackground: UIImageView!
    @IBOutlet weak var itemUpdatePopBackground: UIImageView!
    
    @IBOutlet weak var itemUpdatePop: UIView!
    @IBOutlet weak var itemUpdateEditText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemUpdateButtonL: UIButton!
    
    
    @IBOutlet weak var listTitle: UIImageView!
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
        
        
    }
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        selected3 = list[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ViewControllerTableViewCell
        cell.item.text = list[indexPath.row]
        var numbers = 0
        
        if(saveState.valueForKey(selected3 + "itemarray") != nil){
            let counts = saveState.valueForKey(selected3 + "itemarray") as! [String]
            numbers = counts.count
            
            
        }
        
        if(numbers == 0){
            cell.count.text = "Empty List"
            
        }else{
            cell.count.text = String(numbers)
            
        }
        
        return cell
        
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(list[indexPath.row])
        tableView.reloadData()
        selected = list[indexPath.row]
        selected2 = indexPath.row
        optionPop1.hidden = false
        
    
        

    }

    

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        loadState()
        setFrame()
        toastLabel.hidden = true
        itemUpdatePop.hidden = true
        optionPop1.hidden = true
        


        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func createList(sender: UIButton) {
        itemUpdatePop.hidden = false
        itemUpdateButtonL.setTitle("Add", forState: .Normal)
        
        
        

        
        
    }
    

    
    
    
    @IBOutlet weak var optionPop1: UIView!
    
    @IBOutlet weak var closeOptionPop1Label: UIButton!
    @IBAction func closeOptionPop1(sender: UIButton) {
        
        optionPop1.hidden = true
    }
    
    @IBOutlet weak var deleteListsLabel: UIButton!
    @IBAction func deleteLists(sender: UIButton) {
        list.removeAtIndex(selected2)
        tableView.reloadData()
        toast("Item Removed From List")
        saveState.setValue(list, forKey: "listarray")
        saveState.synchronize()
        optionPop1.hidden = true
        
    }
    
    @IBOutlet weak var openListsLabel: UIButton!
    @IBAction func openLists(sender: UIButton) {
        performSegueWithIdentifier("segue", sender: self)
        optionPop1.hidden = true
        print(selected)
        
    }
    
    

    @IBOutlet weak var editListsLabel: UIButton!
    @IBAction func editLists(sender: UIButton) {
        
        itemUpdatePop.hidden = false
        itemUpdateButtonL.setTitle("Change", forState: .Normal)
        optionPop1.hidden = true
        
        
        
    }
    
    
    
    @IBAction func itemUpdateButton(sender: UIButton) {
        if(!itemUpdateEditText.text!.isEmpty){
            if(itemUpdateButtonL.currentTitle == "Add"){
                if(list.contains(itemUpdateEditText.text!)){
                    toast("Item is in the List")
                }else{
                    list.append(itemUpdateEditText.text!)
                    tableView.reloadData()
                    toast("Item Added to List")
                    saveState.setValue(list, forKey: "listarray")
                    saveState.synchronize()
                    
                }
            }else if(itemUpdateButtonL.currentTitle == "Change"){
                list[selected2] = itemUpdateEditText.text!
                let tmpItem = saveState.valueForKey(selected + "itemarray")
                saveState.setValue(tmpItem, forKey: list[selected2] + "itemarray")
                saveState.setValue(list, forKey: "listarray")
                saveState.synchronize()
                tableView.reloadData()
                toast("Item Changed")
                
                
                
                
            }
            itemUpdatePop.hidden = true
            
        }


    }
    
    
    
    func toast(s: String){
        toastLabel.hidden = false
        toastLabel.text = s
        let delay = 2 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.toastLabel.hidden = true
        }
        
        
    }
    
    
    func setFrame(){
        toastLabel.frame = CGRectMake(w*(40/320), h*(270/568), w*(240/320), h*(24/568))
        
        
        
        itemUpdatePop.frame = CGRectMake(w*(40/320), h*(240/568), w*(246/320), h*(86/568))
        
        itemUpdateEditText.frame = CGRectMake(w*(26/320), h*(28/568), w*(147/320), h*(30/568))
        
        itemUpdateButtonL.frame = CGRectMake(w*(181/320), h*(28/568), w*(46/320), h*(30/568))
        
        createListLabel.frame = CGRectMake(w*(114/320), h*(509/568), w*(102/320), h*(41/568))
        
        
        backgroundImage.frame = CGRectMake(w*(0/320), h*(6/568), w*(320/320), h*(562/568))
        
        bottomBackground.frame = CGRectMake(w*(0/320), h*(492/568), w*(321/320), h*(76/568))
        
        deleteListsLabel.frame = CGRectMake(w*(166/320), h*(20/568), w*(46/320), h*(30/568))
        
        openListsLabel.frame = CGRectMake(w*(26/320), h*(20/568), w*(46/320), h*(30/568))
        
        
        editListsLabel.frame = CGRectMake(w*(105/320), h*(20/568), w*(46/320), h*(30/568))
        
        optionPop1.frame = CGRectMake(w*(41/320), h*(70/568), w*(240/320), h*(77/568))
    
        closeOptionPop1Label.frame = CGRectMake(w*(210/320), h*(46/568), w*(30/320), h*(24/568))
        
        tableView.frame = CGRectMake(w*(33/320), h*(134/568), w*(240/320), h*(347/568))
        
        listTitle.frame = CGRectMake(w*(33/320), h*(69/568), w*(240/320), h*(57/568))
        
        itemUpdatePopBackground.frame = CGRectMake(w*(-5/320), h*(-8/568), w*(263/320), h*(107/568))

        
        
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func loadState(){
        if(saveState.valueForKey("listarray") != nil){
            list = saveState.valueForKey("listarray") as! [String]
        }
        
    }
    
    
    
    
    
    
    
    
    

}

