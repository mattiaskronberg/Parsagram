//
//  LoginViewController.swift
//  Parsagram
//
//  Created by Mattias Kronberg on 2015-07-23.
//  Copyright (c) 2015 Mattias Kronberg. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //Parse Built-in login/register ViewController 
        //I don't know why I can't do this in ViewDidLoad, but it works well, as it will pop up
        //even if the user cancels the signup/login
        if PFUser.currentUser() == nil
        {
            var logInController = PFLogInViewController()
            logInController.delegate = self
            self.presentViewController(logInController, animated:true, completion: nil)
        } else
        {
            performSegueWithIdentifier("toFeed", sender: self)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
