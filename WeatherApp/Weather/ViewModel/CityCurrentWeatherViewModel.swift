//
//  CityCurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import Foundation
import Combine

class CityCurrentWeatherViewModel: ObservableObject {
    
    @Published
    var currentWeather: СityCurrentWeather?
    
    let city: String
    
    private let weatherService = WeatherService()
    private var disposables = Set<AnyCancellable>()
    
    init(city: String) {
        self.city = city
    }
    
    func fetchWeather() {
        weatherService
            .currentWeather(for: city)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else {
                    return
                }
                
                switch value {
                case .failure(let error):
                    print(error)
                    self.currentWeather = nil
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weather in
                guard let self = self else {
                    return
                }
                
                self.currentWeather = weather
            })
            .store(in: &disposables)
    }
}
