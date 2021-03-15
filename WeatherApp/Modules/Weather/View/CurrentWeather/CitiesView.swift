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

        Button(action: {
            viewModel.refresh()
        }, label: {
            Label("Refresh", systemImage: "arrow.clockwise")
        })
    }

    var addCityButton: some View {
        Button(action: {
            isAddingCity.toggle()
        }, label: {
            Label("Add city", systemImage: "plus")
        })
    }

    var grid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(userSettings.cities, id: \.self) {
                cityView(for: $0)

            }
        }
        .padding()
    }

    func cityView(for cityName: String) -> some View {

        CityView(cityName: cityName,
                 currentWeather: viewModel.currentWeather[cityName])
            .contextMenu(ContextMenu(menuItems: {
                Button(action: {
                    // Wait till contenxt menu fully closed.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        withAnimation(.spring()) {
                            userSettings.deleteCity(cityName: cityName)
                        }
                    }
                }, label: {
                    Label("Delete", systemImage: "trash")
                })
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
