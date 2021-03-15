//
//  CityCurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import SwiftUI
import Combine

class CitiesViewModel: ObservableObject {

    @Published
    var currentWeather = [String: CurrentWeather]()

    @ObservedObject
    var userSettings: UserSettings

    private let weatherService = WeatherService()
    private var disposables = Set<AnyCancellable>()

    init(userSettings: UserSettings) {
        self.userSettings = userSettings
        self.userSettings.$cities
            .sink(receiveValue: fetchCurrentWeather(for:))
            .store(in: &disposables)
    }

    func fetchCurrentWeather(for cities: [String]) {

        Publishers.MergeMany(cities.map(weatherService.currentWeather(for:)))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { values in

                switch values {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }

            }, receiveValue: { [weak self] currentWeather in

                guard let self = self else {
                    return
                }

                self.currentWeather[currentWeather.city] = .init(from: currentWeather)
            })
            .store(in: &disposables)
    }

    func refresh() {
        fetchCurrentWeather(for: userSettings.cities)
    }

}
