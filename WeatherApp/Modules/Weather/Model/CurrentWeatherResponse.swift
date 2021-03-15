//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import Foundation

// swiftlint:disable nesting
struct CurrentWeatherResponse: Decodable {

    let weather: [Weather]
    let main: Main
    let city: String

    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case city = "name"
    }

    struct Weather: Codable {

        let description: String
        let icon: String

        enum CodingKeys: String, CodingKey {
            case description = "main"
            case icon
        }
    }

    struct Main: Codable {

        let temperature: Double
        let lowestTemperature: Double
        let highestTemperature: Double

        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case lowestTemperature = "temp_min"
            case highestTemperature = "temp_max"
        }
    }

}
// swiftlint:enable nesting
