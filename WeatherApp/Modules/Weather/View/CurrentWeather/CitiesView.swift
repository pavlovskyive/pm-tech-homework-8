//
//  CityView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct CitiesView: View {
    
    @ObservedObject
    var viewModel: CitiesViewModel
    
    let cities = ["Kyiv", "Dnipro", "London"]
    
    init(cities: [String]) {
        viewModel = CitiesViewModel(cities: cities)
    }
    
    var body: some View {
        content
            .navigationTitle("Current Weather")
    }
    
}

private extension CitiesView {
    
    var content: some View {
        ScrollView(.vertical) {
            grid
        }
        .padding(.top, 1)
        .navigationBarItems(leading: refreshButton,
                            trailing: addCityButton)
    }
    
    var refreshButton: some View {
        Button("Refresh") {
            viewModel.fetchWeathers()
        }
    }
    
    var addCityButton: some View {
        Button(action: {
            print("Add city tapped")
        }) {
            HStack(spacing: 1) {
                Image(systemName: "plus")
                Text("Add city")
            }
        }
    }
    
    var grid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(viewModel.currentWeather) {
                makeCityView($0)
            }
        }
        .onAppear(perform: viewModel.fetchWeathers)
        .padding()
    }
    
    func makeCityView(_ currentWeather: CityCurrentWeather) -> some View {
        CityView(currentWeather: currentWeather)
            .redacted(reason: currentWeather.weather == nil ? .placeholder : [])
    }
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 12), count: 2)
    }

}

struct CitiesCurrentWeather_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(cities: ["Kyiv", "Dnipro", "London"])
    }
}
