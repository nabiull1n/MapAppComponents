//
//  MapButtonView.swift
//  BinomTechTestTask
//
//  Created by Денис Набиуллин on 22.08.2023.
//

import UIKit
import MapKit

protocol MapButtonViewDelegate: AnyObject {
    func mapButtonViewDidTapZoom(_ buttonView: MapButtonView)
    func mapButtonViewDidTapZoomOut(_ buttonView: MapButtonView)
    func mapButtonViewDidTapMyLocation(_ buttonView: MapButtonView)
    func mapButtonViewDidReceiveLongPress(at coordinate: CLLocationCoordinate2D)
}

final class MapButtonView: UIView {
    
    weak var delegate: MapButtonViewDelegate?
    
    var bottomSheetViewBool = true {
        didSet {
            bottomSheetView.isHidden.toggle()
        }
    }
    var zoomInBool: Bool? {
        didSet {
            guard let zoomIn = zoomInBool else { return }
            updateMapSpanWithinLimits(zoomIn: zoomIn)
        }
    }
    
    private let bottomSheetView = BottomSheetView()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Resources.ConstantsMapView.buttonSpacing
        stack.alignment = .center
        return stack
    }()
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mapView)
        mapView.addSubview(buttonsStackView)
        mapView.addSubview(bottomSheetView)
        
        setupGestureRecognizers()
        configureButtons()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestureRecognizers() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    private func createButton(title: String, action: Selector) -> CustomButton {
        let button = CustomButton(title: title)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func updateMapSpanWithinLimits(zoomIn: Bool) {
        var region = mapView.region
        let zoomFactor: Double = zoomIn ? 0.5 : 2.0
        let minDelta: CLLocationDegrees = 0.5
        let maxDelta: CLLocationDegrees = 180.0
        
        region.span.latitudeDelta = min(max(region.span.latitudeDelta * zoomFactor, minDelta), maxDelta)
        region.span.longitudeDelta = min(max(region.span.longitudeDelta * zoomFactor, minDelta), maxDelta)
        
        let newRegion = mapView.regionThatFits(region)
        mapView.setRegion(newRegion, animated: true)
    }
    
    private func configureButtons() {
        let buttonInfo = [(Resources.StandardImageTitle.Buttons.plus, #selector(zoomButtonTapped)),
                          (Resources.StandardImageTitle.Buttons.minus, #selector(zoomOutButtonTapped)),
                          (Resources.StandardImageTitle.Buttons.location, #selector(myLocationButtonTapped)),
                          (Resources.StandardImageTitle.Buttons.circularArrow, #selector(circularArrowButtonTapped))]
        
        for (title, action) in buttonInfo {
            let button = createButton(title: title, action: action)
            
            buttonsStackView.addArrangedSubview(button)
            
            applyButtonConstraints(for: button)
        }
    }
}
// MARK: - addTarget
private extension MapButtonView {
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            delegate?.mapButtonViewDidReceiveLongPress(at: touchCoordinate)
        }
    }
    @objc private func zoomButtonTapped() {
        delegate?.mapButtonViewDidTapZoom(self)
    }
    
    @objc private func zoomOutButtonTapped() {
        delegate?.mapButtonViewDidTapZoomOut(self)
    }
    
    @objc private func myLocationButtonTapped() {
        delegate?.mapButtonViewDidTapMyLocation(self)
    }
    
    @objc private func circularArrowButtonTapped() { }
}
// MARK: - setupConstraints
private extension MapButtonView {
    func applyButtonConstraints(for button: CustomButton) {
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: widthAnchor,
                                          multiplier: Resources.ConstantsMapView.buttonWidthMultiplier),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            buttonsStackView.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor,
                                                  constant: Resources.ConstantsMapView.containerTopMargin),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -Resources.ConstantsMapView.containerTrailingMargin),
            
            bottomSheetView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSheetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSheetView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ])
    }
}
