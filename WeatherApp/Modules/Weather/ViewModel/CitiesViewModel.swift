//
//  CityCurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import Foundation
import Combine

class CitiesViewModel: ObservableObject {

    @Published
    var currentWeather = [CityCurrentWeather]()
    
    private let cities: [String]
    
    private let weatherService = WeatherService()
    private var disposables = Set<AnyCancellable>()
    
    init(cities: [String]) {
        self.cities = cities
        resetCurrentWeather()
    }
    
    func fetchWeathers() {
        
        resetCurrentWeather()
        
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
                
                let optionalIndex = self.currentWeather.firstIndex {
                    $0.cityName == currentWeather.city
                }
                
                guard let index = optionalIndex else {
                    return
                }

                self.currentWeather[index].configure(with: currentWeather)
            })
            .store(in: &disposables)
    }

}

private extension CitiesViewModel {
    
    func resetCurrentWeather() {
        currentWeather = cities.map {
            CityCurrentWeather(cityName: $0)
        }
    }
    
}
