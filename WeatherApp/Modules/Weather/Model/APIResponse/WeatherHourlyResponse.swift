//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 16.03.2021.
//

import Foundation

struct WeatherHourlyResponse: Codable {

    let dateTime: Double
    let conditions: [WeatherConditionResponse]
    let main: WeatherMainResponse

    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case conditions = "weather"
        case main
    }

}
