//
//  FirstViewController.swift
//  SimpleWeatherApp
//
//  Created by Georgij on 23.10.16.
//  Copyright © 2016 Georgii Emeljanow. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate{

    // MARK: IBOutlets
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var updateLbl: UILabel!
    
    var locationManager: CLLocationManager?
    var currentCoordinate: CLLocationCoordinate2D?
    
    var currentForecast: WeatherForecast? {
        didSet {
            reloadUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        locationManager?.requestWhenInUseAuthorization()
        
        currentCoordinate = locationManager?.location?.coordinate
        
        updateCurrentForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentCoordinate = locations.last?.coordinate
    }
    
    @IBAction func updateForecast(_ sender: AnyObject) {
        self.updateCurrentForecast()
    }
}

// MARK: - Update
extension CurrentWeatherViewController {
    func updateCurrentForecast() {
        
        if let coordinate = currentCoordinate {
            NetworkManager.sharedInstance.getWeatherBy(coordinate, { (weather) in
                self.currentForecast = weather
            })
            
        } else {
            print("Update coordinates")
        }
    }
}

// MARK: - UI
extension CurrentWeatherViewController {
    func reloadUI() {
        
        cityLbl.text = currentForecast?.locationName
        
        if let temp = currentForecast?.currentWeatherTemperature {
            temperatureLbl.text = "\(temp > 0 ? "+" : "") \(round(temp))˚C"
        }
        
        if let humidity = currentForecast?.humidity {
            humidityLbl.text = "\(humidity)%"
        }
        
        if let pressure = currentForecast?.pressure {
            pressureLbl.text = "\(round(pressure * 0.750062))"
        }
        
        if let weatherName = currentForecast?.weatherName {
            descriptionLbl.text = "\(weatherName)"
        }
        
        if let timestamp = currentForecast?.timestamp {
            updateLbl.text = "Last update: \(formatDate(timestamp))"
        }
        
        weatherImageView.image = UIImage.init(named: (currentForecast?.imagesDictionary[(currentForecast?.imageName)!])!)
    }
}

// MARK: - Formatters
extension CurrentWeatherViewController{
    func formatDate(_ utc: Double?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone.current
        
        if let time = utc{
            return dateFormatter.string(from: Date(timeIntervalSince1970: time))
        }
        return ""
    }
}


