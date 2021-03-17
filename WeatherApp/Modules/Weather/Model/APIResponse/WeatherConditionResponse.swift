//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 16.03.2021.
//

import Foundation

struct WeatherConditionResponse: Codable {

    let description: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case description = "main"
        case icon
    }

}
