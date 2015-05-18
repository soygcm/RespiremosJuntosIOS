//
//  LugaresViewController.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 12/2/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import UIKit
import MapKit

class LugaresViewController: UIViewController {
    
    var locations = [Location]()

    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getInfo()

    }
    
    
    // MARK: - get Info
    
    func getInfo(){
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                
        var query = PFQuery(className: Location.CLASS)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if error == nil {
                NSLog("Successfully retrieved \(objects.count) messages.")
                
                for object in (objects as! [PFObject]){
                    var location = Location(fromParse: object)
                    self.locations.append(location)
                }
                
                self.addAnnotations()
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
    }
    
    func addAnnotations(){
        
        for location in locations{
            
            var place =  PlaceAnnotation(location: location)
            
            mapView.addAnnotation(place)
            
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
