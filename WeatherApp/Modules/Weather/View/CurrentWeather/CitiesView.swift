//
//  CityView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct CitiesView: View {
    
    @ObservedObject
    private var viewModel: CitiesViewModel
    
    @ObservedObject
    private var userSettings: UserSettings
    
    @State
    private var isAddingCity = false
    
    init() {
        let userSettings = UserSettings()
        
        viewModel = .init(userSettings: userSettings)
        self.userSettings = userSettings
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
        .sheet(isPresented: $isAddingCity) {
            AddCityView(userSettings: userSettings)
        }
    }
    
    var refreshButton: some View {
        Button("Refresh") {
            viewModel.refresh()
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
        .padding()
    }
    
    func makeCityView(_ currentWeather: CityCurrentWeather) -> some View {
        CityView(currentWeather: currentWeather)
            .contextMenu(ContextMenu(menuItems: {
                Button(action: {
                    userSettings.deleteCity(cityName: currentWeather.cityName)
                }) {
                    Label("Delete", systemImage: "trash")
                }
            }))
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
