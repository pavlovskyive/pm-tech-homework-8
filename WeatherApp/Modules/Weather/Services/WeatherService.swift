//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import Foundation
import Combine

final class WeatherService {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

}

extension WeatherService {

    func currentWeather(for city: String) -> AnyPublisher<CurrentWeatherResponse, WeatherError> {
        return fetch(with: makeCurrentWeatherComponents(for: city))
    }

}

private extension WeatherService {

    func fetch<T>(with components: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {

        guard let url = components.url else {
            let error = WeatherError.network(description: "Could not create URL with given components")
            return Fail(error: error).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                pair.data.decode()
            }
            .eraseToAnyPublisher()
    }

}

private extension WeatherService {

    struct OpenWeatherAPI {
        static let key = "ffbcbc836156fd41da6772372c0f4d8b"
        static let host = "api.openweathermap.org"
        static let currentWeatherComponent = "/data/2.5/weather"
        static let scheme = "https"
    }

    func makeCurrentWeatherComponents(for city: String) -> URLComponents {

        var components = URLComponents()

        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.currentWeatherComponent
        components.queryItems = [
            .init(name: "q", value: city),
            .init(name: "units", value: "metric"),
            .init(name: "appid", value: OpenWeatherAPI.key)
        ]

        return components
    }

}
