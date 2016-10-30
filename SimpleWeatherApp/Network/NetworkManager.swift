//
//  NetworkManager.swift
//  SimpleWeatherApp
//
//  Created by Georgij on 27.10.16.
//  Copyright © 2016 Georgii Emeljanow. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import SwiftyJSON

typealias completion = ((WeatherForecast) -> Void)

class NetworkManager {
    
    static let sharedInstance: NetworkManager = {
        let instance = NetworkManager()
        return instance;
    }()
    
    func getWeatherBy(_ currentCoordinate: CLLocationCoordinate2D, _ completion: @escaping completion) -> Void {
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(currentCoordinate.latitude)&lon=\(currentCoordinate.longitude)&APPID=\(Constants.apiKey)").responseJSON { response in
            
            let json = JSON(response.result.value)
            print(json)
            
            let weatherName = json["weather"].arrayValue[0]["main"].stringValue
            let weatherDescription = json["weather"].arrayValue[0]["description"].stringValue
            let humidity = json["main"]["humidity"].doubleValue
            let pressure = json["main"]["pressure"].doubleValue
            let temperature = json["main"]["temp"].double! - 273.15
            let cityName = json["name"].stringValue
            let weatherIcon = json["weather"].arrayValue[0]["icon"].stringValue
            let timestamp = json["dt"].doubleValue
            
            let currentWeather = WeatherForecast.init(locationName: cityName,
                                                      currentWeatherTemperature: temperature,
                                                      humidity: humidity,
                                                      pressure: pressure,
                                                      imageName: weatherIcon,
                                                      timestamp: timestamp,
                                                      weatherName: weatherName,
                                                      weatherDescription: weatherDescription)
            
            completion(currentWeather)
        }
    }
}
