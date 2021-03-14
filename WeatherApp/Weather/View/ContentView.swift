//
//  ContentView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            CitiesView(cities: ["Kyiv", "Dnipro", "London"])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
