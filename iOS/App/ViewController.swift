//
//  ViewController.swift
//  App
//
//  Created by Remi Robert on 06/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cloudFunctionButton: UIToolbar!
    @IBOutlet weak var addNewObjectButton: UIBarButtonItem!
    
    var datas = [String]()
    
    @IBAction func callCloudFunction(sender: AnyObject) {
        PFCloud.callFunctionInBackground("hello", withParameters: nil) { (response: AnyObject?, err: NSError?) in
            if let response = response as? String {
                let alertController = UIAlertController(title: "Response cloud function", message: response, preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            if let err = err {
                self.displayError(err.description)
            }
        }
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        let uuid = NSUUID().UUIDString
        
        let object = PFObject(className: "Item")
        object.setObject(uuid, forKey: "uuid")
        
        object.saveInBackgroundWithBlock { (success: Bool, err: NSError?) in
            if let err = err {
                self.displayError(err.description)
                return
            }
        }
    }
    
    @IBAction func refreshData(sender: AnyObject) {
        PFQuery(className: "Item").findObjectsInBackgroundWithBlock { (items: [PFObject]?, err: NSError?) in
            if let items = items {
                self.datas = items.map({ (item: PFObject) -> String in
                    return item.objectForKey("uuid") as! String
                })
                self.tableView.reloadData()
            }
            if let err = err {
                self.displayError(err.description)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ViewController {
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("cell") else {
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.text = self.datas[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        return cell
    }
}
