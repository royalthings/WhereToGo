//
//  Artwork.swift
//  WhereToGo
//
//  Created by Дмитрий Ага on 7/15/19.
//  Copyright © 2019 Дмитрий Ага. All rights reserved.
//

import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let locationName: String
    let discipline: String
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        
        super.init()
    }

    var subtitle: String? {
        return locationName
    }
}
