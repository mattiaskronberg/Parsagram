//
//  ListOfPostsTableViewController.swift
//  Parsagram
//
//  Created by Mattias Kronberg on 2015-07-23.
//  Copyright (c) 2015 Mattias Kronberg. All rights reserved.
//

import UIKit

// Step by step instruction for this class:
// 1. Get all users PFUser.currentUser() is following
// 2. Get all posts by users PFUser.currentUser() is following
// 3. Display those posts in the tableView
// 4. If a cell in the tableView is tapped, send the associated object to DetailViewController
// 5. Go to DetailViewController and see the details
// This is embedded in a NavigationController, so it's easy to go back again and pick another object
// Keep in mind the getFollowing() method is called in viewDidLoad, which won't runt when you go back again
// This is good in the sense that we don't have to send the same query to Parse again
// However, if the data changed during our visit in DetailViewController, we might want it to query again
// A RefreshControl implementation could solve that problem

class ListOfPostsTableViewController: UITableViewController {
    
    var followedUser = [PFObject]()
    var myPosts = [PFObject]()
    
    //Parse Queries
    
    //Method with query for getting all users PFUser.CurrentUser() is following
    func getFollowing()
    {
        
        
        let query = PFQuery(className: "Following") //Following is my Parse class defining the relationship between two Users. In this case one user is following another user
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil
            {
                if let results = objects as? [PFObject]
                {
                    var followingArray = [PFObject]()
                    for object in results
                    {
                        var following = object["following"] as! PFObject
                        followingArray.append(following)
                    }
                    
                    //When all followers have been added to my array I can call the next method, for getting the posts.
                    self.followedUser = followingArray
                }
            }
        }
    }
    
    //Method for getting posts
    func getPosts()
    {
        let query = PFQuery(className: "Posts")
        query.whereKey("posted_by", containedIn: followedUser)
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil
            {
                if let results = objects as? [PFObject]
                {
                    // Now I have all my posts and can reload my tableView
                    // An alternative approach is to do the JSON type-thing
                    // here, and create a model for your cells, but I'm lazy
                    // and will do that in cellForRowAtIndexPath
                    self.myPosts = results
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFollowing()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myPosts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! UITableViewCell
        
        let cellData = myPosts[indexPath.row]
        cell.textLabel?.text = cellData["postTitle"] as? String
        
        return cell
    }
    
    //Okay, time for the detail view. When I press a cell, I want to see a detail view of that object
    //with information from the PFObject we fetched to myPosts (our datasource array)
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("goToDetailView", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetailView"
        {
            if let destination = segue.destinationViewController as? DetailViewController
            {
                //We want the DetailViewController to receive the corresponding object
                //so we find this by looking in our array at the index for the selected row 
                destination.object = myPosts[tableView.indexPathForSelectedRow()!.row]
            }
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
