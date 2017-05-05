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
        bought.removeAtIndex(indexPath.row)
        saveState.setValue(bought, forKey: selected + "boughtarray")
        saveState.synchronize()
        tableView3.reloadData()
        toast("Item Deleted from Bough List")
        
    }
    


    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var boughtTitle: UIImageView!

    @IBOutlet weak var tableView3: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadState()
        tableView3.reloadData()
        setFrame()

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

    
    func setFrame(){
        
        backgroundImage.frame = CGRectMake(w*(0/320), h*(6/568), w*(320/320), h*(562/568))
        
        toastLabel.frame = CGRectMake(w*(33/320), h*(133/568), w*(240/320), h*(21/568))
        
        tableView3.frame = CGRectMake(w*(33/320), h*(134/568), w*(240/320), h*(347/568))
        
        boughtTitle.frame = CGRectMake(w*(33/320), h*(69/568), w*(240/320), h*(57/568))
        
    
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
 


}
