//
//  SecondViewController.swift
//  iShop
//
//  Created by ai13aay on 01/05/2017.
//  Copyright © 2017 ai13aay. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let h = UIScreen.mainScreen().bounds.height
    let w = UIScreen.mainScreen().bounds.width

    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
        
    }
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! ViewControllerTableViewCell2
        cell.item2.text = list[indexPath.row]
        return cell
        
        
        
    }
    


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrame()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setFrame(){
        
        tableView.frame = CGRectMake(w*(40/320), h*(57/568), w*(240/320), h*(382/568))
        
        
    }


}
