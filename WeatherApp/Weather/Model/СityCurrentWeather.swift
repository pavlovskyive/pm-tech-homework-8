//
//  СityCurrentWeather.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import Foundation

struct СityCurrentWeather: Decodable {

    let dateTime: Int
    let weather: [Weather]
    let main: Main
    let city: String

    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case weather
        case main
        case city = "name"
    }
    
    struct Weather: Codable {

        let identifier: Int
        let main: String
        let description: String
        let icon: String

        enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case main
            case description
            case icon
        }
    }

    struct Main: Codable {

        let temperature: Double
        let minimumTemperature: Double
        let maximumTemperature: Double

        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case minimumTemperature = "temp_min"
            case maximumTemperature = "temp_max"
        }
    }

}
