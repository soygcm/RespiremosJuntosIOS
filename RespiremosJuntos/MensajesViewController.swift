//
//  MensajesViewController.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 10/2/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import UIKit

class MensajesViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let mensajes = [
        "Gracias por instalar esta wevada",
        "DEJA DE FUMAR YA!!!!",
        "si sigues fumando vas a quedar como esta imagen *imagen horrible de las consecuencias de fumar*"
    ]
    
    
    @IBAction func loginButton(sender: AnyObject) {
        
        // Set permissions required from the facebook user account
        let permissionsArray = [ "user_about_me", "user_relationships", "user_birthday", "user_location"]
    
        
        PFFacebookUtils.logInWithPermissions(permissionsArray, block: { (user: PFUser!, error: NSError!) -> Void in
            
            
            self.activityIndicator.stopAnimating()
            
            if user == nil {
                var errorMessage = ""
                if error == nil{
                    NSLog("Oh oh, el usuario cancelo el Facebook login.")
                    errorMessage = "Oh oh, el usuario cancelo el Facebook login."
                }else{
                    NSLog("Uh oh. An error occurred: %@", error)
                    errorMessage = error.localizedDescription
                }
                
                var alert = UIAlertView(title: "Error", message: errorMessage, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Dismiss")
                alert.show()
                
            }else{
                
                self.userDetails()
                
                if user.isNew {
                    NSLog("User with facebook signed up and logged in!")
                }else{
                    NSLog("User with facebook logged in!")
                }
                
            }
            
            
        })
        
        self.activityIndicator.startAnimating()

        
    }
    
    func userDetails() {
        
        let request = FBRequest.requestForMe()
        request.startWithCompletionHandler { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            
            if error == nil{
                
                let userData = result as NSDictionary
                
                let facebookID = userData["id"] as String
                let name = userData["name"] as String
                let location = userData["location"] as NSDictionary
                let locationName = location["name"] as String
                let gender = userData["gender"] as String
                let birthday = userData["birthday"] as String
                let relationship = userData["relationship_status"] as String
                
                let pictureURL = NSURL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large&return_ssl_resources=1")

                NSLog("fbID: \(facebookID) name: \(name) birthday: \(birthday) ")
                
                
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        if PFUser.currentUser() != nil &&
            PFFacebookUtils.isLinkedWithUser(
            PFUser.currentUser()) {
                
                userDetails()
                
        }

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
        return mensajes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("mensajeCell", forIndexPath: indexPath) as MensajeCell

        // Configure the cell...
        
        cell.mensajeLabel?.text = mensajes[indexPath.row]

        return cell
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
