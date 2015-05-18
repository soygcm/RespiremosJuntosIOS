//
//  Benefit.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 10/5/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import Foundation

class User{
    
    static let FB_ID = "facebookId"
    static let TYPE = "tipo"
    static let SIN_FUMAR = "sinFumar"
    static let TYPE_NO = 1
    static let TYPE_EX = 2
    static let TYPE_YES = 3
    static let TYPE_LEAVING = 4
    static let TYPE_NO_STR = "No fuma"
    static let TYPE_EX_STR = "Ex fumador"
    static let TYPE_YES_STR = "Fumador"
    static let TYPE_LEAVING_STR = "Dejando de Fumar"
    static let NAME = "nombre"
    static let PUNTOS = "points"
    static let HELPING = "helpingSmokers"
    
    var nombre = ""
    var sinFumar = ""
    var facebookId = ""
    var tipoString = ""
    var id = ""

    var puntos = 0
    var tipo = 0

    var selected = false
    
    init(){
        
    }
    
    init(fromParse object: PFObject){
        
         self.nombre = (object[User.NAME] as? String)!
        
    }

}