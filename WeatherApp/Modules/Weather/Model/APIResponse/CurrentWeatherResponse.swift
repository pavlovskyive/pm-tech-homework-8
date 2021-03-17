//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import Foundation

struct CurrentWeatherResponse: Decodable {

    let conditions: [WeatherConditionResponse]
    let main: WeatherMainResponse
    let city: String

    enum CodingKeys: String, CodingKey {
        case conditions = "weather"
        case main
        case city = "name"
    }

}
