//
//  CityCurrentWeatherView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 12.03.2021.
//

import SwiftUI

struct CityView: View {
    
    @ObservedObject
    var viewModel: CityCurrentWeatherViewModel
    
    let city: String
    
    init(city: String) {
        self.city = city
        viewModel = CityCurrentWeatherViewModel(city: city)
    }
    
    var body: some View {
        content
            .onAppear(perform: viewModel.fetchWeather)
            .listStyle(GroupedListStyle())
    }

}

private extension CityView {
    
    var content: some View {
        CurrentWeatherDetailsView(from: viewModel.currentWeather)
            .redacted(reason: viewModel.currentWeather == nil ? .placeholder : [])
    }

}

struct CurrentWeatherView_Previews: PreviewProvider {
    
    static var previews: some View {
        CityView(city: "Kyiv")
            .frame(width: 200, height: 100, alignment: .center)
    }

}
