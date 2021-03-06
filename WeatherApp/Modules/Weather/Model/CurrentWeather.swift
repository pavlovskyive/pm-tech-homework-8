//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct CurrentWeather {

    let city: String

    let currentTemperature: Int
    let highestTemperature: Int
    let lowestTemperature: Int

    let description: String
    var icon: Image

    init(from currentWeather: CurrentWeatherResponse) {

        self.city = currentWeather.city

        self.currentTemperature = Int(currentWeather.main.temperature)
        self.highestTemperature = Int(currentWeather.main.highestTemperature)
        self.lowestTemperature = Int(currentWeather.main.lowestTemperature)

        guard let condition = currentWeather.conditions.first else {
            self.description = ""
            self.icon = .init(systemName: "sun.min")

            return
        }

        description = condition.description
        icon = IconMapper.image(for: condition.icon)
    }
}
