//
//  ViewController.swift
//  chat
//
//  Created by Dinh Thi Minh on 11/25/15.
//  Copyright © 2015 Dinh Thi Minh. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        self.login(usernameTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func onSignup(sender: AnyObject) {
        self.signup(self.usernameTextField.text!, password: passwordTextField.text!)
    }

    func login(username:String, password:String) {
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("ChatViewController", sender: self)
            } else {
                print(error!)
                // The login failed. Check error to see why.
                let errorString = error!.userInfo["error"] as? NSString
                let alertView = UIAlertView(title: "Error message", message: errorString! as String, delegate: nil, cancelButtonTitle: "Close")
                alertView.show()
            }
        }
    }
    
    func signup(username:String, password:String) {
        var user = PFUser()
        user.username = username
        user.password = password
        user.email = "email7@example.com"
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                let alertView = UIAlertView(title: "Error message", message: errorString! as String, delegate: nil, cancelButtonTitle: "Close")
                alertView.show()
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                let chuoi = user.username! + " has signed up successfully"
                let alertView = UIAlertView(title: "Notification", message: chuoi as String, delegate: nil, cancelButtonTitle: "Close")
                alertView.show()
            }
        }
    }
}

