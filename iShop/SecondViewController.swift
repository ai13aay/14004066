//
//  SecondViewController.swift
//  iShop
//
//  Created by ai13aay on 01/05/2017.
//  Copyright © 2017 ai13aay. All rights reserved.
//

import UIKit
var bought = [String]()
var name3 = String()


class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let h = UIScreen.mainScreen().bounds.height
    let w = UIScreen.mainScreen().bounds.width
    var selected2 = -100
    

    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        selected2 = indexPath.row
        optionPop.hidden = false
        name3 = item[indexPath.row]
        
        
    }
    
    func editItem(index: NSIndexPath){
        item[index.row] = "Changed"
        
    }
    
    
    @IBOutlet weak var buysListLabale: UIButton!
    @IBOutlet weak var optionPopBackground: UIImageView!
    @IBOutlet weak var itemUpdatePopBackground: UIImageView!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    @IBOutlet weak var bottomBackground: UIImageView!
    
    @IBOutlet weak var itemsText: UITextField!
    
    @IBOutlet weak var optionPop: UIView!
    

    @IBOutlet weak var stepperDown: UIButton!
  

    @IBOutlet weak var stepperUp: UIButton!
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var itemUpdatePop: UIView!
    
    @IBOutlet weak var itemUpdateEditText: UITextField!
    
    @IBOutlet weak var itemUpdateButtonL: UIButton!
    
    @IBOutlet weak var addItemLabel: UIButton!
    
    @IBOutlet weak var deleteItemLabel: UIButton!
    
    @IBOutlet weak var toastLabel: UILabel!
    @IBOutlet weak var itemTitle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsText.text = "0"
        itemUpdatePop.hidden = true
        optionPop.hidden = true
        toastLabel.hidden = true
        loadState()
        setFrame()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func itemUpdateButton(sender: UIButton) {
        
        

        
        if(!itemUpdateEditText.text!.isEmpty){
            
            if(itemUpdateButtonL.currentTitle == "Add"){
                
                if(item.contains(itemUpdateEditText.text!)){
                    toast("Item is in the List")
                }else{
                    item.append(itemUpdateEditText.text!  + " " + itemsText.text!)
                    tableView.reloadData()
                    toast("Item Added to List")
                    saveState.setValue(item, forKey: selected + "itemarray")
                    saveState.synchronize()
                    
                }
                
                
                itemUpdatePop.hidden = true
                
                
            }else if(itemUpdateButtonL.currentTitle == "Change"){
                
                item[selected2] = itemUpdateEditText.text! + itemsText.text!
                
                itemUpdatePop.hidden = true
                toast("Item changed")
                
                selected2 = -100
                saveState.setValue(item, forKey: selected + "itemarray")
                saveState.synchronize()
                
                
                
            }
            tableView.reloadData()
        }

            
            
            
            
        }
    

    
    @IBAction func addItem(sender: UIButton) {
        itemsText.text = "1"
        itemUpdatePop.hidden = false
        itemUpdateButtonL.setTitle("Add", forState: .Normal)
    }

    
    
    
    

    @IBOutlet weak var editTextLabel: UIButton!
   
    @IBAction func editText(sender: AnyObject) {
        
        if(selected2 != -100){
            optionPop.hidden = true
            
            itemUpdatePop.hidden = false
            itemUpdateButtonL.setTitle("Change", forState: .Normal)
            
            itemUpdateEditText.text = ""
            itemsText.text = "1"
            
            
            
        }
    }
    
    
    @IBAction func deleteItem(sender: AnyObject) {
        
        if(selected2 != -100){
            
            item.removeAtIndex(selected2)
            tableView.reloadData()
            selected2 = -100
            optionPop.hidden = true
            saveState.setValue(item, forKey: selected + "itemarray")
            saveState.synchronize()
            toast("Item Removed from List")

            
        }
        
        
    }
    @IBAction func closeOptionPop(sender: AnyObject) {
        optionPop.hidden = true
    }
    
    
    @IBOutlet weak var closeOptionPopLabel: UIButton!
    
    
    
    @IBAction func stepperM(sender: UIButton) {
        
       
        var n:Int = Int(itemsText.text!)!
        if(n>1){
            n = n - 1
            itemsText.text = String(n)
            
        }
    }
    
    
    
    @IBAction func addToBuyList(sender: UIButton) {
        if(selected2 != 100){
            
            let s = item[selected2]
            bought.append(s)
            saveState.setValue(bought, forKey: selected + "boughtarray")
            saveState.synchronize()
            item.removeAtIndex(selected2)
            saveState.setValue(item, forKey: selected + "itemarray")
            saveState.synchronize()
            
            toast("Item Added to Bought List")
            selected2 = -100
            optionPop.hidden = true
            tableView.reloadData()
            
            
            
        }
        
        
        
    }
    
    
    @IBAction func stepperP(sender: UIButton) {
        
        var n:Int = Int(itemsText.text!)!
        n = n + 1
        itemsText.text = String(n)
    }
    
    
    
    @IBOutlet weak var closePopL: UIButton!
    
    
    @IBAction func closePop(sender: UIButton) {
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
        toastLabel.frame = CGRectMake(w*(40/320), h*(272/568), w*(240/320), h*(24/568))
        
        
        
        itemUpdatePop.frame = CGRectMake(w*(31/320), h*(221/568), w*(248/320), h*(126/568))
        
        itemUpdateEditText.frame = CGRectMake(w*(28/320), h*(20/568), w*(207/320), h*(30/568))
        
        itemUpdateButtonL.frame = CGRectMake(w*(98/320), h*(90/568), w*(56/320), h*(30/568))
        
        addItemLabel.frame = CGRectMake(w*(40/320), h*(511/568), w*(102/320), h*(41/568))
        
        deleteItemLabel.frame = CGRectMake(w*(163/320), h*(30/568), w*(47/320), h*(30/568))
        
        itemsText.frame = CGRectMake(w*(94/320), h*(58/568), w*(68/320), h*(30/568))
        
        stepperUp.frame = CGRectMake(w*(170/320), h*(58/568), w*(30/320), h*(30/568))
        
        stepperDown.frame = CGRectMake(w*(56/320), h*(58/568), w*(30/320), h*(30/568))
        
        backGroundImage.frame = CGRectMake(w*(0/320), h*(6/568), w*(320/320), h*(562/568))
        
        bottomBackground.frame = CGRectMake(w*(0/320), h*(492/568), w*(321/320), h*(76/568))
        closePopL.frame = CGRectMake(w*(214/320), h*(90/568), w*(34/320), h*(30/568))
        
        deleteItemLabel.frame = CGRectMake(w*(163/320), h*(30/568), w*(47/320), h*(30/568))
        editTextLabel.frame = CGRectMake(w*(98/320), h*(30/568), w*(47/320), h*(30/568))
        
        closeOptionPopLabel.frame = CGRectMake(w*(193/320), h*(63/568), w*(30/320), h*(30/568))
        nextScreenLabel.frame = CGRectMake(w*(183/320), h*(511/568), w*(102/320), h*(41/568))
        optionPop.frame = CGRectMake(w*(40/320), h*(163/568), w*(243/320), h*(106/568))
    
        tableView.frame = CGRectMake(w*(40/320), h*(163/568), w*(240/320), h*(325/568))
        
        itemTitle.frame = CGRectMake(w*(33/320), h*(69/568), w*(240/320), h*(57/568))
        
        itemUpdatePopBackground.frame = CGRectMake(w*(0/320), h*(-15/568), w*(267/320), h*(169/568))
        
        optionPopBackground.frame = CGRectMake(w*(-8/320), h*(0/568), w*(260/320), h*(117/568))
        
        buysListLabale.frame = CGRectMake(w*(35/320), h*(30/568), w*(47/320), h*(30/568))
        
        
    }

    func loadState(){
        if(saveState.valueForKey(selected + "itemarray") != nil){
            item = saveState.valueForKey(selected + "itemarray") as! [String]
            
        }else{
            item.removeAll()
        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    @IBOutlet weak var nextScreenLabel: UIButton!
    
    @IBAction func nextScreen(sender: UIButton) {
        
        
    }
    
    


}
