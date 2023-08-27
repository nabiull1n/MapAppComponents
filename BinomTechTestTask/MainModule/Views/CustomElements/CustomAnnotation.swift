//
//  CustomAnnotation.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 23.08.2023.
//

import MapKit

final class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var annotationImage: UIImage
    var userPhoto: UIImage
    
    var width: Int
    var height: Int
    
    init(annotationData: CustomAnnotationModel) {
        self.coordinate = annotationData.coordinate
        self.title = annotationData.title 
        self.subtitle = annotationData.subtitle 
        self.annotationImage = annotationData.annotationImage
        self.userPhoto = annotationData.userPhoto
        
        self.width = annotationData.width
        self.height = annotationData.height
        
        super.init()
    }
}
