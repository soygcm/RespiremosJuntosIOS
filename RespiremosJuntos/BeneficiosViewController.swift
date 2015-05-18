//
//  BeneficiosViewController.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 12/2/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import UIKit

class BeneficiosViewController: UITableViewController {
    
    var beneficios = [Benefit]()
    var user = PFUser.currentUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getSinFumar()
        
        
        getInfo()
        
    }
    
    var startTime = NSTimeInterval()
    var sinFumar: NSDate!
    
    func update() {
        
//
        let daysBetween = self.betweenDate(sinFumar, toDateTime: NSDate(),unit: NSCalendarUnit.CalendarUnitDay)
        let hoursBetween = self.betweenDate(sinFumar, toDateTime: NSDate(),unit: NSCalendarUnit.CalendarUnitHour)
        let minutesBetween = self.betweenDate(sinFumar, toDateTime: NSDate(),unit: NSCalendarUnit.CalendarUnitMinute)
//
        
        let minutesInHour = 60
        let hoursInDay = 24
        let minutesInDay = minutesInHour * hoursInDay
        
        var mins = Double(minutesBetween.minute)
        let days = Int( mins / Double(minutesInDay))
//        mins -= Double(days * minutesInDay)
        let hours = Int( mins / Double(minutesInHour) )
        let hoursLeft = hours - (days * hoursInDay)
//        mins -= Double(hours * minutesInHour)
        let minutes = Int(mins)
        let minutesLeft = minutes - (hours * minutesInHour)
        
        NSLog(" \(days), \(hoursLeft), \(minutesLeft)")
        
        updateProgress(days, hours: hours, minutes: minutes)
        
        // Something cool
        
        /*
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        let secondsInDay = (60.0*60.0*24.0)
        
        //calculate the days in elapsed time.
        let days = UInt(elapsedTime / secondsInDay)
        elapsedTime -= (NSTimeInterval(days) * secondsInDay)
        
        //calculate the minutes in elapsed time.
        let minutes = UInt(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt(elapsedTime * 100)
        
        
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strDays = days > 9 ? String(days):"0" + String(days)
        let strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        let strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        NSLog( "\(strDays):\(strMinutes):\(strSeconds)")
        */
        
    }

    /**
	 * Devuelve \c true si alguno de los objetos
	 * esta esperando un cambio en un valor y se recibe el cambio.
	 * Si alguno esta esperando un cambio en ese valor y
	 * recibe un cambio en otro, devuelve \c false
	 * @param days
	 * @param hours
	 * @param minutes
	 * @return
	 */
	func isNeededRefresh(days: Int, hours: Int, minutes: Int) ->Bool {
		
        var isNeeded = false
        
        var g = beneficios.generate()
        
        var beneficio = g.next()
        var hasNext = true
        
        while !isNeeded && beneficio != nil {
            
            
            if ( self.days != days){
                isNeeded = true;
            }
            if (beneficio!.waitingMinutes() && self.minutes != minutes){
                isNeeded = true;
            }
            if (beneficio!.waitingHours() && self.hours != hours){
                isNeeded = true;
            }
//
            beneficio = g.next()
            
        }
		
		
		return isNeeded
	}
    
    func updateProgress(days: Int, hours: Int, minutes: Int){
        
//        if( isNeededRefresh(days, hours: hours, minutes: minutes) ){
        
        if self.minutes != minutes{
            for beneficio in beneficios {
                
                beneficio.days = days
                beneficio.hours = hours
                beneficio.minutes = minutes
                
                tableView.reloadData()
                
            }
            
        }
        
        self.days = days
        self.hours = hours
        self.minutes = minutes
        
        
    }
    
    var days = 0
    var hours = 0
    var minutes = 0

    
    func getSinFumar(){
        self.user.fetchInBackgroundWithBlock { (object: PFObject!, error: NSError!) -> Void in
            
            if(error == nil){
                
                var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
                
                self.sinFumar = self.user[User.SIN_FUMAR] as! NSDate
                
                self.startTime = self.sinFumar.timeIntervalSinceNow
                
            }
            
        }
    }
    
    func betweenDate(fromDateTime:NSDate,  toDateTime:NSDate, unit: NSCalendarUnit) -> NSDateComponents{
        
        var fromDate:NSDate? = nil
        var toDate:NSDate? = nil
        var duration: NSTimeInterval = 0
        
        var calendar = NSCalendar.currentCalendar()
        
        calendar.rangeOfUnit( unit, startDate: &fromDate, interval: &duration, forDate: fromDateTime)
        
        calendar.rangeOfUnit(unit, startDate: &toDate, interval: &duration, forDate: toDateTime)
        
        var difference = calendar.components(unit, fromDate: fromDate!, toDate: toDate!, options: nil)
        
        
        return difference
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - get Info
    
    func getInfo(){
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var query = PFQuery(className:Benefit.CLASS)
        query.orderByAscending("order")
        query.whereKey(Benefit.TIME_TYPE, notEqualTo: Benefit.NAN)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if error == nil {
                NSLog("Successfully retrieved \(objects.count) messages.")
                
                for object in (objects as! [PFObject]){
                    var benefit = Benefit(fromParse: object)
                    self.beneficios.append(benefit)
                }
                
                self.tableView.reloadData()
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return beneficios.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("beneficioCell", forIndexPath: indexPath) as! BenefitCell
        
//        let cell = UITableViewCell()
        
        // Configure the cell...
        
        let beneficio = beneficios[indexPath.row]
        
        cell.beneficio = beneficio
        cell.fill()
        
        return cell
    }
    
    // MARK: - resize frame
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
