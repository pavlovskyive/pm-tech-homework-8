//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 16.03.2021.
//

import Foundation

struct ForecastResponse: Codable {

    var hourly: [WeatherHourlyResponse]

    enum CodingKeys: String, CodingKey {
        case hourly = "list"
    }

}
