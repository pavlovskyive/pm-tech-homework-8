//
//  AddCityViewModel.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 15.03.2021.
//

import Foundation
import Combine

class AddCityViewModel: ObservableObject {
    
    @Published
    var currentWeather = CityCurrentWeather(cityName: "")

    @Published
    var cityName: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        let scheduler = DispatchQueue(label: "AddCityViewModel")
        
        $cityName
            .sink {
                self.currentWeather = .init(cityName: $0)
            }
            .store(in: &cancellable)
        
        $cityName
            .dropFirst(1)
            .debounce(for: .seconds(1), scheduler: scheduler)
            .sink(receiveValue: checkCity(_:))
            .store(in: &cancellable)
    }
    
    private var weatherService = WeatherService()
    private var disposables = Set<AnyCancellable>()
    
    func checkCity(_ cityName: String) {
        
        weatherService.currentWeather(for: cityName)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print(error)
                default: break
                }
            }) { [weak self] currentWeatherResponce in
                
                guard let self = self else {
                    return
                }
                
                print(currentWeatherResponce)
                self.currentWeather.configure(with: currentWeatherResponce)
            }.store(in: &disposables)
    }
}
