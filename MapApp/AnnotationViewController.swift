//
//  AnnotationViewController.swift
//  MapApp
//
//  Created by Martin Dimitrov on 25.11.19.
//  Copyright © 2019 Appolica Learning. All rights reserved.
//

import UIKit

class AnnotationViewController: UIViewController {
    
    private let temperature: String?
    private let humidity: String?
    private let windSpeed: String?
    private let cityName: String?
        
    @IBOutlet weak var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.text = temperature
        }
    }
    
    @IBOutlet weak var humidityLabel: UILabel! {
        didSet {
            humidityLabel.text = humidity
        }
    }
    
    @IBOutlet weak var windSpeedLabel: UILabel! {
        didSet {
            windSpeedLabel.text = windSpeed
        }
    }
    
    @IBOutlet weak var cityNameLabel: UILabel! {
        didSet {
            cityNameLabel.text = cityName
        }
    }
    @IBAction func dismissOnTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    init(temperature: String, humidity: String, windSpeed: String, cityName: String) {
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.cityName = cityName
        super.init(nibName: "AnnotationView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.temperature = nil
        self.humidity = nil
        self.windSpeed = nil
        cityName = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTransition()
    }
    
    private func setupTransition() {
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }

}
