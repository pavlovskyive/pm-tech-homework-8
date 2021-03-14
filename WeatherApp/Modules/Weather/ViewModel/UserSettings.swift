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
    var cities: [String] {
        didSet {
            UserDefaults.standard.setValue(cities, forKey: "cities")
        }
    }

    init() {
        cities = UserDefaults.standard.object(forKey: "cities") as? [String] ?? ["Kyiv", "Dnipro"]
    }
}
