//
//  DataService.swift
//  WhereToGo
//
//  Created by Дмитрий Ага on 7/14/19.
//  Copyright © 2019 Дмитрий Ага. All rights reserved.
//

import Foundation
import Firebase
import MapKit
import Contacts

let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_PLACES = DB_BASE.child("places")
    
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    var REF_PLACES: DatabaseReference {
        return _REF_PLACES
    }
    
    func getPlaces(handler: @escaping (_ returnedPlaces: [Artwork]) -> ()) {
        var placeArray = [Artwork]()
        REF_PLACES.observeSingleEvent(of: .value) { (placeSnapshot) in
            guard let placeSnapshot = placeSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for place in placeSnapshot {
                let title = place.childSnapshot(forPath: "title").value as! String
                let locationName = place.childSnapshot(forPath: "locationName").value as! String
                let discipline = place.childSnapshot(forPath: "discipline").value as! String
                let latitude = place.childSnapshot(forPath: "latitude").value as! CLLocationDegrees
                let longitude = place.childSnapshot(forPath: "longitude").value as! CLLocationDegrees
 
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                let artPlace = Artwork(title: title, locationName: locationName, discipline: discipline, coordinate: coordinate)
                placeArray.append(artPlace)
                
            }
            handler(placeArray)
        } 
    }
    
    func randomPlace(handler: @escaping (_ returnedPlace: [Artwork]) -> ()) {
        var selectedPlace = [Artwork]()

        REF_PLACES.observeSingleEvent(of: .value) { (placeSnapshot) in
            guard let placeSnapshot = placeSnapshot.children.allObjects as? [DataSnapshot] else { return }

            if let randomPlace = placeSnapshot.randomElement() {
                let title = randomPlace.childSnapshot(forPath: "title").value as! String
                let locationName = randomPlace.childSnapshot(forPath: "locationName").value as! String
                let discipline = randomPlace.childSnapshot(forPath: "discipline").value as! String
                let latitude = randomPlace.childSnapshot(forPath: "latitude").value as! CLLocationDegrees
                let longitude = randomPlace.childSnapshot(forPath: "longitude").value as! CLLocationDegrees
                
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let artPlace = Artwork(title: title, locationName: locationName, discipline: discipline, coordinate: coordinate)
                selectedPlace = [artPlace]
            } 
            handler(selectedPlace)
        }
    }
}
