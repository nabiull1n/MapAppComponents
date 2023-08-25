//
//  ExtCLLocation.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 25.08.2023.
//

import MapKit

extension CLLocation {
    func centerMapOnLocation(in mapView: MKMapView, withSpan span: CLLocationDegrees) {
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude,
                                            longitude: coordinate.longitude)
        let region = MKCoordinateRegion(center: center,
                                        span: MKCoordinateSpan(latitudeDelta: span,
                                                               longitudeDelta: span))
        mapView.setRegion(region, animated: true)
    }
    
    func addLocationAnnotation(to mapView: MKMapView, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}
