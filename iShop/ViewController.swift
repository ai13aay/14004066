//
//  ViewController.swift
//  iShop
//
//  Created by ai13aay on 01/05/2017.
//  Copyright © 2017 ai13aay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let h = UIScreen.mainScreen().bounds.height
    let w = UIScreen.mainScreen().bounds.width
    
    @IBOutlet weak var createListLabel: UIButton!
    @IBOutlet weak var deleteListLabel: UIButton!
    
    @IBOutlet weak var toastLabel: UILabel!
    var list = ["gggggg","rrrrr","rfrf"]
    
    @IBOutlet weak var itemUpdatePop: UIView!
    @IBOutlet weak var itemUpdateEditText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemUpdateButtonL: UIButton!
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
        
    }
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ViewControllerTableViewCell
        cell.item.text = list[indexPath.row]
        cell.count.text = String(list.count)
        return cell
        
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(list[indexPath.row])
        list = ["1","2","3","4","5"]
        tableView.reloadData()
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        setFrame()
        toastLabel.hidden = true
        itemUpdatePop.hidden = true
        


        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func createList(sender: UIButton) {
        itemUpdatePop.hidden = false
        itemUpdateButtonL.setTitle("Add", forState: .Normal)
        
        
        

        
        
    }
    
    @IBAction func deleteList(sender: UIButton) {
        itemUpdatePop.hidden = false
        itemUpdateButtonL.setTitle("Delete", forState: .Normal)
        
        
        
    }
    
    @IBAction func itemUpdateButton(sender: UIButton) {
        if(itemUpdateButtonL.currentTitle == "Delete"){
            if list.contains(itemUpdateEditText.text!) {
                var x = 0
                while(x < list.count){
                    
                    if(list[x] == itemUpdateEditText.text){
                        list.removeAtIndex(x)
                        tableView.reloadData()
                        toast("Item Removed From List")
                    }
                    x = x + 1
                }
                
            }else{
                toast("Item Not In List")
            }
        } else if (itemUpdateButtonL.currentTitle == "Add"){
            if(list.contains(itemUpdateEditText.text!)){
                toast("Item is in the List")
            }else{
                list.append(itemUpdateEditText.text!)
                tableView.reloadData()
                toast("Item Added to List")
            }
            
        }
        itemUpdatePop.hidden = true

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
        
        createListLabel.frame = CGRectMake(w*(20/320), h*(518/568), w*(80/320), h*(30/568))
        
        deleteListLabel.frame = CGRectMake(w*(215/320), h*(518/568), w*(85/320), h*(30/568))
        
    }
    

}

