//
//  WeatherMain.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 16.03.2021.
//

import Foundation

struct WeatherMainResponse: Codable {

    let temperature: Double
    let lowestTemperature: Double
    let highestTemperature: Double

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case lowestTemperature = "temp_min"
        case highestTemperature = "temp_max"
    }

}
