//
//  WeatherForecast.swift
//  SimpleWeatherApp
//
//  Created by Georgij on 23.10.16.
//  Copyright © 2016 Georgii Emeljanow. All rights reserved.
//

import Foundation

class WeatherForecast {
    let currentWeatherTemperature: Double?
    let locationName: String?
    let imageName: String
    let humidity: Double?
    let pressure: Double?
    let timestamp: Double?
    let weatherName: String?
    let weatherDescription: String?
    
    init(locationName: String?,
         currentWeatherTemperature: Double?,
         humidity: Double?,
         pressure: Double?,
         imageName: String,
         timestamp: Double?,
         weatherName: String?,
         weatherDescription: String?) {
        
        self.currentWeatherTemperature = currentWeatherTemperature
        self.pressure = pressure
        self.humidity = humidity
        self.locationName = locationName
        self.imageName = imageName
        self.timestamp = timestamp
        self.weatherName = weatherName
        self.weatherDescription = weatherDescription
    }
    
    let imagesDictionary = [
        "01d" : "sun",
        "01n" : "sun",
        "02d" : "fewClouds",
        "02n" : "fewClouds",
        "03d" : "scatteredClouds",
        "03n" : "scatteredClouds",
        "04d" : "brokenСlouds",
        "04n" : "brokenСlouds",
        "10d" : "rain",
        "10n" : "rain",
        "11d" : "thunderstorm",
        "11n" : "thunderstorm",
        "13d" : "snow",
        "13n" : "snow",
        "50d" : "fog",
        "50n" : "fog"
    ]
    
    func convertImage() -> String {
        let localIamgeName = imagesDictionary[self.imageName]
        return localIamgeName!
    }
}
