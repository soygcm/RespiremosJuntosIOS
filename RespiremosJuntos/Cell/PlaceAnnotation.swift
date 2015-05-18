//
//  Place.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 13/5/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import UIKit

import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    
    let title: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
    
    init(location: Location) {
        
        self.title = location.title()
        self.subtitle = location.subtitle()
        self.coordinate = location.coordinate()
        
        super.init()
    }
    
}
