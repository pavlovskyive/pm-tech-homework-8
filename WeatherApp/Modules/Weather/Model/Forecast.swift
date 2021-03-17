//
//  Forecast.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 16.03.2021.
//

import SwiftUI

struct Forecast {

    let data: [WeatherData]

    private lazy var dailyWeather: [Date: [WeatherData]] = {

        data.reduce(into: [Date: [WeatherData]]()) { acc, cur in

            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: cur.date)

            guard let date = Calendar.current.date(from: dateComponents) else {
                return
            }

            let existing = acc[date] ?? []

            acc[date] = existing + [cur]
        }
    }()

    init(from forecastResponse: ForecastResponse) {
        data = forecastResponse.hourly.map {
            WeatherData(from: $0)
        }
    }

    struct WeatherData: Identifiable {

        // swiftlint:disable identifier_name
        let id = UUID()
        // swiftlint:enable identifier_name

        let temperature: Int
        let description: String
        let icon: Image

        let date: Date

        init(from hourlyResponse: WeatherHourlyResponse) {
            temperature = Int(hourlyResponse.main.temperature)
            date = Date(timeIntervalSince1970: hourlyResponse.dateTime)

            guard let condition = hourlyResponse.conditions.first else {
                self.description = ""
                self.icon = .init(systemName: "sun.min")

                return
            }

            description = condition.description
            icon = IconMapper.image(for: condition.icon)
        }

    }

}

extension Forecast {

    var dates: [Date] {
        mutating get {
            dailyWeather.keys.sorted()
        }
    }

    mutating func forecastForDate(_ date: Date) -> [WeatherData] {
        dailyWeather[date] ?? []
    }

}
