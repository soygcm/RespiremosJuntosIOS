//
//  MensajesViewController.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 10/2/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import UIKit


class MensajesViewController: UITableViewController {
    
    var mensajes = [Message]()

    
    
    func userDetails() {

        let request = FBRequest.requestForMe()
        request.startWithCompletionHandler { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            
            if error == nil{
                
                let userData = result as! NSDictionary
                
                let facebookID = userData["id"] as! String
                let name = userData["name"] as! String
                let location = userData["location"] as! NSDictionary
                let locationName = location["name"]as! String
                let gender = userData["gender"] as! String
                let birthday = userData["birthday"] as! String
                let relationship = userData["relationship_status"] as! String
                
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
                
//                userDetails()
                mostrarMensajes()
                
                
        }else{
            
        }
        
        self.tableView.estimatedRowHeight = 40
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
    }
    
    
    func deleteMensaje(mensaje: Message){
        
        mensajes.removeAtIndex(mensaje.index)
        updateIndexes()
        
        tableView.beginUpdates()
        
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: mensaje.index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
        
        tableView.endUpdates()
        
    }
    
    
    
//    - (void) textFieldDidBeginEditing:(UITextField *)textField {
//    UITableViewCell *cell;
//    
//    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
//    // Load resources for iOS 6.1 or earlier
//    cell = (UITableViewCell *) textField.superview.superview;
//    
//    } else {
//    // Load resources for iOS 7 or later
//    cell = (UITableViewCell *) textField.superview.superview.superview;
//    // TextField -> UITableVieCellContentView -> (in iOS 7!)ScrollView -> Cell!
//    }
//    [tView scrollToRowAtIndexPath:[tView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    }
    
    func updateIndexes(){
        
//        if(mensajes.count == 1){
//            var message = mensajes[0]
//            message.index = 0
//        }else
        if (mensajes.count >= 1){
            for i in 0...mensajes.count-1{
                var message = mensajes[i]
                message.index = i
            }
        }
        
        
        
    }
    
    
    func mostrarMensajes(){
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var query = PFQuery(className:"Message")
        query.whereKey("to", equalTo:PFUser.currentUser())
        query.whereKey("aceptado", notEqualTo: false)
        query.includeKey("from")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if error == nil {
                NSLog("Successfully retrieved \(objects.count) messages.")

                for object in (objects as! [PFObject]){
                    var mensaje = Message(fromParse: object)
                    self.mensajes.append(mensaje)
                }
                
                self.tableView.reloadData()
                self.tableView.setContentOffset(CGPointZero, animated: false)
                self.updateIndexes()
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("mensajeCell", forIndexPath: indexPath) as! MensajeCell

        // Configure the cell...
        
        var message = mensajes[indexPath.row]
        
        cell.message = message
        cell.mensajesController = self
        cell.fill()

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
            
            mensajes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    

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
    
    override func viewWillAppear(animated: Bool) {
        resizeView()
        tableView.setContentOffset(CGPointZero, animated: false)
    }
    
    func resizeView(){
        if (NSProcessInfo().operatingSystemVersion.majorVersion >= 7) {
            self.view.frame =  CGRectMake(0,20,self.view.frame.size.width,self.view.frame.size.height-20)
            self.view.bounds = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        resizeView()
        tableView.setContentOffset(CGPointZero, animated: false)
    }


}
