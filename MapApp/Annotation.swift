//
//  Annotation.swift
//  MapApp
//
//  Created by Martin Dimitrov on 25.11.19.
//  Copyright © 2019 Appolica Learning. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotation: NSObject, MKAnnotation {

    //MKAnnotation protocol
    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    public var subtitle: String?
    
    //Initializer
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate     = coordinate
        self.title          = title
        self.subtitle       = subtitle
        
        super.init()
    }
}
