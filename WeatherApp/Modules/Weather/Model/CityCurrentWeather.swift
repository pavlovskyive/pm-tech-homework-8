//
//  CityCurrentWeather.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct CityCurrentWeather: Identifiable {
    
    let id = UUID()
    
    let cityName: String
    var weather: CurrentWeather?
    
    init(cityName: String) {
        self.cityName = cityName
    }
    
    struct CurrentWeather {

        let currentTemperature: Int
        let highestTemperature: Int
        let lowestTemperature: Int
        
        let description: String
        let icon: Image
        
        init(currentWeather: CurrentWeatherResponse) {

            self.currentTemperature = Int(currentWeather.main.temperature)
            self.highestTemperature = Int(currentWeather.main.highestTemperature)
            self.lowestTemperature = Int(currentWeather.main.lowestTemperature)
            
            guard let weatherDescription = currentWeather.weather.first else {
                self.description = ""
                self.icon = .init(systemName: "sun.max")
                
                return
            }
            
            self.description = weatherDescription.description
            self.icon = .init(systemName: "sun.max")
        }
    }

}

extension CityCurrentWeather {
    
    mutating func configure(with currentWeather: CurrentWeatherResponse) {
        self.weather = .init(currentWeather: currentWeather)
    }
    
}
