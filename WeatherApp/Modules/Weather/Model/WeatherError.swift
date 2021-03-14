//
//  WeatherError.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import Foundation

enum WeatherError: Error {
    case parsing(description: String)
    case network(description: String)
}
