//
//  ViewController.swift
//  MapApp
//
//  Created by Martin Dimitrov on 25.11.19.
//  Copyright © 2019 Appolica Learning. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    private struct Constants {
        static let APIToken = "c00564d0-8739-47cc-9914-f5c53008313e"
        static let getPointDataURL = "https://api.airvisual.com/v2/nearest_city?lat={{LATITUDE}}&lon={{LONGITUDE}}&key={{API_KEY}}"
    }
    
    private var vSpinner: UIView?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
    }
    
    @IBAction func didTapOnLocation(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            mapView.removeAnnotations(mapView.annotations)
            let locationInView = sender.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(coordinate: tappedCoordinate)
        }
    }
    func addAnnotation(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else {
            return
        }
        let formattedURLString = Constants.getPointDataURL
            .replacingOccurrences(of: "{{LATITUDE}}", with: "\(coordinate.latitude)")
            .replacingOccurrences(of: "{{LONGITUDE}}", with: "\(coordinate.longitude)")
            .replacingOccurrences(of: "{{API_KEY}}", with: Constants.APIToken)
        print(formattedURLString)
        
        guard let url = URL(string: formattedURLString) else {
            return
        }
        
        showSpinner(onView: self.view)
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            self.removeSpinner()
            guard let data = data else { return }
            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    let annotationController = AnnotationViewController.init(temperature: "\(apiResponse.data.current.weather.tp)", humidity: "\(apiResponse.data.current.weather.hu)", windSpeed: "\(apiResponse.data.current.weather.ws)", cityName: apiResponse.data.city)
                    self.show(annotationController, sender: nil)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }
}

extension ViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}
