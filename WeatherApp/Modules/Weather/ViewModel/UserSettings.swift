//
//  UserSettings.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import Foundation
import Combine

class UserSettings: ObservableObject {

    @Published
    private(set) var cities: [String] {
        didSet {
            UserDefaults.standard.setValue(cities, forKey: "cities")
        }
    }

    init() {
        cities = UserDefaults.standard.object(forKey: "cities") as? [String] ?? ["Kyiv", "Dnipro"]
    }
}

extension UserSettings {
    
    public func addCity(cityName: String) {
        if !cities
            .map({ $0.lowercased() })
            .contains(cityName.lowercased()) {

            cities.append(cityName)
        }
    }
    
    public func deleteCity(cityName: String) {
        cities
            .removeAll{ $0 == cityName }
    }
    
}
