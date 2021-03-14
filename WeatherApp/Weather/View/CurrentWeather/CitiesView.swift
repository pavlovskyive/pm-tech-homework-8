//
//  CityView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct CitiesView: View {
    
    let cities = ["Kyiv", "Dnipro", "Oslo"]
    
    var body: some View {
        ScrollView(.vertical) {
            grid
        }
        .padding(.top, 1)
        .navigationTitle("Current Weather")
    }
    
}

private extension CitiesView {
    
    var grid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(cities, id: \.self) { city in
                CityView(city: city)
            }
        }
        .padding()
    }
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 12), count: 2)
    }

}

struct CitiesCurrentWeather_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView()
    }
}
