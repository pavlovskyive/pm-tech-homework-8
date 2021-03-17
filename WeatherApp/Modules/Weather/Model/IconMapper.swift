//
//  IconMapper.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 17.03.2021.
//

import SwiftUI

struct IconMapper {

    static private let iconMap: [String: String] = [
        "01d": "sun.min.fill",
        "02d": "cloud.sun.fill",
        "03d": "cloud.fill",
        "04d": "smoke.fill",
        "09d": "cloud.rain.fill",
        "10d": "cloud.sun.rain.fill",
        "11d": "cloud.bolt.fill",
        "13d": "snow",
        "50d": "cloud.fog.fill",
        "01n": "moon.stars.fill",
        "02n": "cloud.moon.fill",
        "03n": "cloud.fill",
        "04n": "smoke.fill",
        "09n": "cloud.rain.fill",
        "10n": "cloud.moon.rain.fill",
        "11n": "cloud.bolt.fill",
        "13n": "snow",
        "50n": "cloud.fog.fill"
    ]

    static func image(for icon: String) -> Image {
        Image(systemName: iconMap[icon] ?? "sun.min")
    }

}
