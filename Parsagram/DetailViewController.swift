//
//  DetailViewController.swift
//  Parsagram
//
//  Created by Mattias Kronberg on 2015-07-23.
//  Copyright (c) 2015 Mattias Kronberg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var objectIdLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var ourCustomPropertyLabel: UILabel!
    
    //So this is our variable holding the object we want do display details about
    var object: PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        objectIdLabel.text = object?.objectId
        createdAtLabel.text = object?.createdAt as? String
        ourCustomPropertyLabel.text = object?.objectForKey("ourColumn") as? String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
