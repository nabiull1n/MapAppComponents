//
//  ExtMKAnnotation.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 25.08.2023.
//

import MapKit

extension MKAnnotation {
    func createCustomCalloutView(using annotationModel: CustomAnnotationModel) -> CustomAnnotationCalloutView {
        let customCalloutView = CustomAnnotationCalloutView(width: annotationModel.width,
                                                            height: annotationModel.height)
        customCalloutView.addLabels(title: annotationModel.title,
                                    subtitle: annotationModel.subtitle)
        
        return customCalloutView
    }
}
