//
//  ThirdViewController.swift
//  iShop
//
//  Created by ai13aay on 04/05/2017.
//  Copyright © 2017 ai13aay. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let h = UIScreen.mainScreen().bounds.height
    let w = UIScreen.mainScreen().bounds.width
    var unbuy  = String()
    var selectedIndex = Int()
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (bought.count)
        
    }
    
    
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell3")
        cell.textLabel?.text = bought[indexPath.row]
        
        return cell
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        unbuy = bought[indexPath.row]
        selectedIndex = indexPath.row
        optionPop3.hidden = false
        
        
    }
    


    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var boughtTitle: UIImageView!

    @IBOutlet weak var tableView3: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadState()
        tableView3.reloadData()
        setFrame()
        toastLabel.hidden = true
        optionPop3.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loadState(){
        if(saveState.valueForKey(selected + "boughtarray") != nil){
            bought = saveState.valueForKey(selected + "boughtarray") as! [String]
            tableView3.reloadData()
            
            
            
        }else{
            bought.removeAll()
            tableView3.reloadData()
        }
        
    }
    
    
    
    
  
    
    @IBOutlet weak var deleteBuyLabel: UIButton!
    
    @IBAction func deleteBuy(sender: UIButton) {
        
        bought.removeAtIndex(selectedIndex)
        saveState.setValue(bought, forKey: selected + "boughtarray")
        saveState.synchronize()
        tableView3.reloadData()
        toast("Item deleted from bought list")
        optionPop3.hidden = true
        
        
        
    }
    
    @IBOutlet weak var unBuyLabel: UIButton!
    
    @IBAction func unBuyFunc(sender: UIButton) {
        if(item.contains(unbuy)){
            toast("item is in the list")
            optionPop3.hidden = true
        } else {
            item.append(unbuy)
            saveState.setValue(item, forKey: selected + "itemarray")
            saveState.synchronize()
            toast("Item return to buy List")
            bought.removeAtIndex(selectedIndex)
            saveState.setValue(bought, forKey: selected + "boughtarray")
            saveState.synchronize()
            tableView3.reloadData()
            optionPop3.hidden = true
            
        }
    }
    
    @IBOutlet weak var optionPop3: UIView!
    @IBOutlet weak var optionPop3Background: UIImageView!
    
    @IBOutlet weak var closePopLabel: UIButton!
    
    @IBAction func closePop(sender: UIButton) {
        optionPop3.hidden = true
    }

    
    func setFrame(){
        
        backgroundImage.frame = CGRectMake(w*(0/320), h*(6/568), w*(320/320), h*(562/568))
        
        toastLabel.frame = CGRectMake(w*(33/320), h*(274/568), w*(240/320), h*(21/568))
        
        tableView3.frame = CGRectMake(w*(33/320), h*(134/568), w*(240/320), h*(347/568))
        
        boughtTitle.frame = CGRectMake(w*(33/320), h*(69/568), w*(240/320), h*(57/568))
        
        optionPop3.frame = CGRectMake(w*(33/320), h*(235/568), w*(240/320), h*(71/568))
        
        optionPop3Background.frame = CGRectMake(w*(-7/320), h*(0/568), w*(258/320), h*(81/568))
        
        deleteBuyLabel.frame = CGRectMake(w*(147/320), h*(21/568), w*(53/320), h*(30/568))
        unBuyLabel.frame = CGRectMake(w*(38/320), h*(21/568), w*(53/320), h*(30/568))
        
        closePopLabel.frame = CGRectMake(w*(208/320), h*(41/568), w*(30/320), h*(30/568))
    }
    
    @IBOutlet weak var toastLabel: UILabel!
    func toast(s: String){
        toastLabel.hidden = false
        toastLabel.text = s
        let delay = 2 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.toastLabel.hidden = true
        }
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
 


}
