//
//  Benefit.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 10/5/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import Foundation

class Benefit{
    
    static let HOUR = "HOUR"
    static let MINUTE = "MINUTE"
    static let DAY = "DAY"
    static let MONTH = "MONTH"
    static let YEAR = "YEAR"
    static let NAN = "NAN"
    
    static let CLASS = "Benefits"
    static let TEXT = "text"
    static let TIME_TOTAL = "timeTotal"
    static let TIME_TYPE = "timeType"
    static let IMAGE = "image"
    
    var text = ""
    var timeType = ""
    var id = ""
    var total = 0
    var minutes = 0
    var hours = 0
    var days = 0
    
    init(fromParse object: PFObject){
        
        self.text = (object[Benefit.TEXT] as? String)!
        
        
        self.total = (object [Benefit.TIME_TOTAL] as? Int )!
        self.timeType = (object [Benefit.TIME_TYPE] as? String )!
        
        
    }
    
    func percentFormated() -> String{
        return "\( percent() * 100 ) %"
    }
    
    func  percent() -> Float {
    
        var progress = 0
        var totalMins = 0
        
        if(timeTypeMinute()){
            progress = minutes
            totalMins = total
        }
        if(timeTypeHour() ){
            progress = hours
            totalMins = total * 60
        }
        if(timeTypeDay() ){
            progress = days
            totalMins = total * 24 * 60
        }
        if(timeTypeMonth() ){
            progress = days;
            totalMins = total * 30 * 24 * 60
        }
        if(timeTypeYear() ){
            progress = days
            totalMins = total * 365 * 24 * 60
        }
        
        var percent = Float(minutes) / Float (totalMins)
//        var percent = Double(progress*100) / Double (total)

        if (percent>=1) {
            percent = 1
        }
        
        return percent
    }

    
    func timeTypeHour() -> Bool{
        return (timeType == Benefit.HOUR )
    }
    func timeTypeMinute() -> Bool{
        return (timeType == Benefit.MINUTE )
    }
    func timeTypeDay() -> Bool{
        return (timeType == Benefit.DAY )
    }
    func timeTypeMonth() -> Bool{
        return (timeType == Benefit.MONTH )
    }
    func timeTypeYear() -> Bool{
        return (timeType == Benefit.YEAR )
    }
    
    func totalString()->String {
        var tiempo = "\(self.total) "
        if(timeTypeMinute()){
            tiempo += "minutos"
        }
        if(timeTypeHour() ){
            tiempo += "horas"
        }
        if(timeTypeDay() ){
            tiempo += "dias"
        }
        if(timeTypeMonth() ){
            tiempo += "meses"
        }
        if(timeTypeYear() ){
            tiempo += "años"
        }
        return tiempo;
    }
    

    func  waitingMinutes() -> Bool{
        return ( percent() < 100 && timeTypeMinute() )
    }
    func  waitingDays() -> Bool{
        return ( percent() < 100 && (timeTypeDay() || timeTypeMonth() || timeTypeYear()) )
    }
    func  waitingHours() -> Bool{
        return ( percent() < 100 && timeTypeHour() )
    }

}