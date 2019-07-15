//
//  ViewController.swift
//  WhereToGo
//
//  Created by Дмитрий Ага on 7/14/19.
//  Copyright © 2019 Дмитрий Ага. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    //MARK: - let and var
    fileprivate let regionRadius: CLLocationDistance = 1500
    var artworks: [Artwork] = []
    //Nikolaev coordinate
    fileprivate let initialLocation = CLLocation(latitude: 46.9659100, longitude: 31.997400)
    
    //MARL: - Outlets
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - get places
        DataService.instance.getPlaces { (returnedPlacesArray) in
            self.artworks = returnedPlacesArray
            self.mapView.addAnnotations(self.artworks)
        }
        
        centerMapOnLocation(location: initialLocation)
    }
    
    
    //MARK: - center map on location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //MARK: - Actions
    @IBAction func whereToGoBtnWasPressed(_ sender: Any) {
        DataService.instance.randomPlace { (randomPlace) in
            self.artworks = randomPlace
            for item in self.artworks {
                let pointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = item.coordinate
                pointAnnotation.title = item.title
                pointAnnotation.subtitle = item.subtitle
                
                self.mapView.addAnnotation(pointAnnotation)
                //select Annotation
                self.mapView.selectAnnotation(pointAnnotation, animated: true)
                let coordinateRegion = MKCoordinateRegion(center: item.coordinate, latitudinalMeters: self.regionRadius, longitudinalMeters: self.regionRadius)
                self.mapView.setRegion(coordinateRegion, animated: true)
            }
        }
    }
}




