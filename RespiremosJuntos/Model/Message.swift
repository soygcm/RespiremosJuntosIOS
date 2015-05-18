//
//  Benefit.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 10/5/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import Foundation

class Message{
    
    static let CLASS = "Message"
    static let TEXT = "text"
    static let FROM = "from"
    static let ANSWER = "answer"
    static let ACCEPTED = "aceptado"
    static let CREATE = "createdAt"

    var text = ""
    var id = ""
    var aceptado:Bool = false
    var respondiendo:Bool = false
    var from: User = User()
    var answer = ""
    var parseObject = PFObject(className: CLASS)
    var index = 0
    
    
    init(){
        
    }
    
    init(fromParse object: PFObject){
        
        self.parseObject = object

        if let val: AnyObject = object[Message.TEXT]{
            self.text = val as! String
        }
        
        if let val: AnyObject = object[Message.ACCEPTED]{
            self.aceptado = val as! Bool
        }

        if let val: AnyObject =  object[Message.ANSWER]{
            self.answer = val as! String
        }
        
        if let val: AnyObject =  object[Message.FROM]{
            let from = val as! PFUser
            
            self.from = User(fromParse: from)
        }

        self.id = object.objectId
        
        // self.text = (object["text"] as? String)!
        
    }

}