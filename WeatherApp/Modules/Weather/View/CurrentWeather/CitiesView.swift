//
//  CityView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct CitiesView: View {
    
    @ObservedObject
    private var viewModel = CitiesViewModel()
    
    @ObservedObject
    private var userSetting = UserSettings()
    
    @State
    private var isAddingCity = false
    
    var body: some View {
        content
            .navigationTitle("Current Weather")
    }
    
}

private extension CitiesView {
    
    func fetchWeather() {
        viewModel.fetchCurrentWeather(for: userSetting.cities)
    }
    
    var content: some View {
        ScrollView(.vertical) {
            grid
        }
        .padding(.top, 1)
        .navigationBarItems(leading: refreshButton,
                            trailing: addCityButton)
        .sheet(isPresented: $isAddingCity, onDismiss: {
            fetchWeather()
        }) {
            AddCityView(userSettings: userSetting)
        }
    }
    
    var refreshButton: some View {
        Button("Refresh") {
            fetchWeather()
        }
    }
    
    var addCityButton: some View {
        Button(action: {
            isAddingCity.toggle()
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
        .onAppear(perform: fetchWeather)
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
        CitiesView()
    }
}
