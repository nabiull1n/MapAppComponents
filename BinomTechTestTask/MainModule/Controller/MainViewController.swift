//
//  MainViewController.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 22.08.2023.
//

import UIKit
import MapKit
import CoreLocation

final class MainViewController: UIViewController {
    
    private let mapViewContainer = MapButtonView()
    private var locationManager: CLLocationManager?
    private var locationPermissionGranted = false
    private let profileImageSize = CGSize(width: 50, height: 50)
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        view = mapViewContainer
    }
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewContainer.mapView.delegate = self
        mapViewContainer.delegate = self
        
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }
    
    private func showLocationDisabledAlert() {
        let alert = UIAlertController.createLocationDisabledAlert()
        present(alert, animated: true, completion: nil)
    }
    // cоздаем и настраиваем профильное изображение
    private func createProfileImageView(withinBounds bounds: CGRect, named: UIImage) -> UIImageView {
        let profileImageView = UIImageView(image: named)
        profileImageView.frame = CGRect(origin: .zero, size: profileImageSize)
        profileImageView.center = CGPoint(x: bounds.midX, y: bounds.midY - 4)
        
        return profileImageView
    }
    // cоздаем и настраиваем кастомную каллаут-вью
    private func createCustomCalloutView(using customCalloutViewData: CreateCustomCalloutView,
                                         title: String,
                                         subtitle: String) -> CustomAnnotationCalloutView {
        let customCalloutView = CustomAnnotationCalloutView(width: customCalloutViewData.width,
                                                            height: customCalloutViewData.height)
        customCalloutView.addLabels(title: title, subtitle: subtitle)
        
        return customCalloutView
    }
    // обновляет геолокацию на карте и добавляет аннотацию для текущей позиции пользователя
    private func handleLocationUpdate(_ location: CLLocation) {
        location.centerMapOnLocation(in: mapViewContainer.mapView, withSpan: 0.1)
        location.addLocationAnnotation(to: mapViewContainer.mapView, title: "Мое местоположение")
        
        locationManager?.stopUpdatingLocation()
    }
    
    private func animateBottomSheet(show: Bool) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
// MARK: - extension MapButtonViewDelegate
extension MainViewController: MapButtonViewDelegate {
    func mapButtonViewDidTapZoom(_ buttonView: MapButtonView) {
        mapViewContainer.zoomInBool = true
    }
    
    func mapButtonViewDidTapZoomOut(_ buttonView: MapButtonView) {
        mapViewContainer.zoomInBool = false
    }
    
    func mapButtonViewDidTapMyLocation(_ buttonView: MapButtonView) {
        locationPermissionGranted ? locationManager?.startUpdatingLocation() : showLocationDisabledAlert()
    }
    
    func mapButtonViewDidReceiveLongPress(at coordinate: CLLocationCoordinate2D) {
        let customAnnotationData =  CustomAnnotationModel(coordinate: coordinate,
                                                          title: "Иван",
                                                          subtitle: "GPS, 14:00",
                                                          annotationImage: UIImage(named: "customAnnotation")!,
                                                          userPhoto: UIImage(named: "profileImage")!,
                                                          width: 120,
                                                          height: 50
        )
        let customAnnotation = CustomAnnotation(annotationData: customAnnotationData)
        
        customAnnotation.coordinate = coordinate
        mapViewContainer.mapView.addAnnotation(customAnnotation)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                locationPermissionGranted = true
            case .denied, .restricted:
                print("Пользователь отклонил доступ к геолокации.")
            default:
                break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            handleLocationUpdate(location)
        }
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        // создаем MKAnnotationView с изображением аннотации
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
        annotationView.image = annotation.annotationImage
        // устанавливает смещение центра отображения аннотации относительно её координаты на карте
        annotationView.centerOffset = CGPoint(x: 0, y: -annotationView.bounds.size.height / 2)
        
        let profileImageView = createProfileImageView(withinBounds: annotationView.bounds,
                                                      named: annotation.userPhoto)
        // Создаем кастомную вьюху рядом с аннотацией
        let customCalloutView = createCustomCalloutView(using: CreateCustomCalloutView(width: annotation.width,
                                                                                       height: annotation.height),
                                                        title: annotation.title ?? "",
                                                        subtitle: annotation.subtitle ?? "")
        
        annotationView.addSubview(profileImageView)
        annotationView.addSubview(customCalloutView)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // показываем или скрываем bottomSheetView
        mapViewContainer.bottomSheetViewBool.toggle()
        animateBottomSheet(show: true)
    }
}
