//
//  CustomAnnotationModel.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 25.08.2023.
//

import UIKit
import MapKit

struct CustomAnnotationModel {
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    var annotationImage: UIImage
    var userPhoto: UIImage
    
    var width: Int
    var height: Int
}

struct CreateCustomCalloutView {
    var width: Int
    var height: Int
}
