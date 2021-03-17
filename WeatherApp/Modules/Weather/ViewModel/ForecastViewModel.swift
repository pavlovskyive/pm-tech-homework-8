//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 16.03.2021.
//

import Foundation
import Combine

class ForecastViewModel: ObservableObject {

    @Published
    var forecast: Forecast?

    private(set) var cityName: String

    private let weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()

    init(cityName: String) {
        self.cityName = cityName
    }

    func fetchForecast() {

        weatherService.forecast(for: cityName)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { value in

                switch value {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] forecastResponse in

                guard let self = self else {
                    return
                }

                self.forecast = .init(from: forecastResponse)
            })
            .store(in: &cancellables)

    }

}
