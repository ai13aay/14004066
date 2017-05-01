//
//  SecondViewController.swift
//  iShop
//
//  Created by ai13aay on 01/05/2017.
//  Copyright © 2017 ai13aay. All rights reserved.
//

import UIKit
var item = [String]()

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let h = UIScreen.mainScreen().bounds.height
    let w = UIScreen.mainScreen().bounds.width

    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (item.count)
        
    }
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! ViewControllerTableViewCell2
        cell.item2.text = item[indexPath.row]
        return cell
        
        
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var itemUpdatePop: UIView!
    
    @IBOutlet weak var itemUpdateEditText: UITextField!
    
    @IBOutlet weak var itemUpdateButtonL: UIButton!
    
    @IBOutlet weak var addItemLabel: UIButton!
    
    @IBOutlet weak var deleteItemLabel: UIButton!
    
    @IBOutlet weak var toastLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemUpdatePop.hidden = true
        toastLabel.hidden = false
        loadState()
        setFrame()
        
        
    }
    

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func itemUpdateButton(sender: UIButton) {
        
        if(itemUpdateButtonL.currentTitle == "Delete"){
            if item.contains(itemUpdateEditText.text!) {
                var x = 0
                while(x < item.count){
                    
                    if(item[x] == itemUpdateEditText.text){
                        item.removeAtIndex(x)
                        tableView.reloadData()
                        toast("Item Removed From List")
                        saveState.setValue(item, forKey: selected + "itemarray")
                        saveState.synchronize()
                        
                    }
                    x = x + 1
                }
                
            }else{
                toast("Item Not In List")
            }
        } else if (itemUpdateButtonL.currentTitle == "Add"){
            if(item.contains(itemUpdateEditText.text!)){
                toast("Item is in the List")
            }else{
                item.append(itemUpdateEditText.text!)
                tableView.reloadData()
                toast("Item Added to List")
                saveState.setValue(item, forKey: selected + "itemarray")
                saveState.synchronize()
                
            }
            
        }
        itemUpdatePop.hidden = true

        
        
    }
    

    
    @IBAction func addItem(sender: UIButton) {
        itemUpdatePop.hidden = false
        itemUpdateButtonL.setTitle("Add", forState: .Normal)
    }

    @IBAction func deleteItem(sender: UIButton) {
        itemUpdatePop.hidden = false
        itemUpdateButtonL.setTitle("Delete", forState: .Normal)
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
        toastLabel.frame = CGRectMake(w*(40/320), h*(28/568), w*(241/320), h*(21/568))
        
        tableView.frame = CGRectMake(w*(40/320), h*(57/568), w*(240/320), h*(382/568))
        
        itemUpdatePop.frame = CGRectMake(w*(40/320), h*(451/568), w*(241/320), h*(70/568))
        
        itemUpdateEditText.frame = CGRectMake(w*(20/320), h*(20/568), w*(130/320), h*(30/568))
        
        itemUpdateButtonL.frame = CGRectMake(w*(175/320), h*(20/568), w*(46/320), h*(30/568))
        
        addItemLabel.frame = CGRectMake(w*(20/320), h*(518/568), w*(80/320), h*(30/568))
        
        deleteItemLabel.frame = CGRectMake(w*(215/320), h*(518/568), w*(85/320), h*(30/568))
        
    }

    func loadState(){
        if(saveState.valueForKey(selected + "itemarray") != nil){
            item = saveState.valueForKey(selected + "itemarray") as! [String]
        }else{
            item.removeAll()
        }
    }


}
