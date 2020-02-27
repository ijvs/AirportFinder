//
//  AirportMapViewController.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AirportMapViewController: UIViewController {

    private let annotationReuseIdentifier = "annotationReuseIdentifier"

    var presenter: AirportPresenter
    private let mapView: MKMapView = MKMapView()

    init(presenter: AirportPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .yellow
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupView()
        presenter.attach(view: self)
        presenter.load()
    }

    private func setupView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        mapView.userTrackingMode = .follow
        mapView.showsUserLocation = true
        mapView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func centerMap() {
        let radius: Double = Double(presenter.radius)
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate,
                           latitudinalMeters: radius * 1000,
                           longitudinalMeters: radius * 1000)
        mapView.setRegion(region, animated: true)
    }
}

extension AirportMapViewController: AirportViewControllerContract {

    var identifier: String {
        self.description
    }

    func update(state: ViewState<[AirportViewModel], AirportErrorViewModel>) {
        switch state {
        case .loading:
            break
        case .error:
            break
        case .empty:
            break
        case .content(let content):
            mapView.removeAnnotations(mapView.annotations)
            for airport in content {
                if let airport = airport as? AirportAnnotation.ViewModel {
                    let annotation = AirportAnnotation(model: airport)
                    mapView.addAnnotation(annotation)
                }
            }
            centerMap()
        }
    }
}

// MARK: - MKMapViewDelegate
extension AirportMapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is AirportAnnotation else {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationReuseIdentifier)

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseIdentifier)
        }
        annotationView?.canShowCallout = true
        annotationView?.displayPriority = .required

        return annotationView
    }
}
