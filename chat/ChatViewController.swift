//
//  ChatViewController.swift
//  chat
//
//  Created by Dinh Thi Minh on 11/25/15.
//  Copyright © 2015 Dinh Thi Minh. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages:[PFObject] = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSend(sender: AnyObject) {
        var gameScore = PFObject(className: "Message")
        gameScore["text"] = messageTextField.text
        gameScore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print(gameScore["text"])
            } else {
                // There was a problem, check error.description
            }
        }

    }
    
    

    func onTimer() {
        var query = PFQuery(className:"Message")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                // There was an error
            } else {
                // objects has all the Posts the current user liked.
//                for obj in objects! {
//                    print(obj)
//                }
                
                self.messages = objects!
                
                self.tableView.reloadData()
            }
        }

    }

}

extension ChatViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageTableViewCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = self.messages[indexPath.row]["text"] as? String
        
        return cell
    }
}
