//
//  AddCityView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct AddCityView: View {

    @Environment(\.presentationMode) var presentation
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject
    var userSettings: UserSettings

    @ObservedObject
    var viewModel = AddCityViewModel()

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Add City")
        }
    }

}

private extension AddCityView {

    var content: some View {

        VStack {
            Spacer()

            if !viewModel.cityName.isEmpty {
                cityView
            }

            form

            Spacer()

        }
        .animation(.easeInOut)
        .padding()
        .font(.title3)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }

    var cityView: some View {

        CityView(cityName: viewModel.cityName,
                 currentWeather: viewModel.currentWeather)
            .frame(height: 150)
            .padding(.bottom, 20)
    }

    var form: some View {

        VStack {
            textField
            Divider()
            addButton
        }
        .padding(.horizontal)
        .background(background)
        .cornerRadius(10)
    }

    var background: some View {

        if colorScheme == .dark {
            return Color(.secondarySystemGroupedBackground)
        } else {
            return Color(.systemBackground)
        }
    }

    var textField: some View {

        TextField("Enter city name or postal code", text: $viewModel.cityName)
            .padding(.top, 10)
            .padding()
    }

    var addButton: some View {

        Button(action: { addCity() }, label: { buttonLabel })
            .disabled(viewModel.currentWeather == nil)
            .padding()
    }

    var buttonLabel: some View {
        HStack {
            Spacer()
            Text("Add City")
            Spacer()
        }
    }

    func addCity() {

        guard let cityName = viewModel.currentWeather?.city else {
            return
        }

        userSettings.addCity(cityName: cityName)
        presentation.wrappedValue.dismiss()
    }

}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView(userSettings: UserSettings())
        AddCityView(userSettings: UserSettings()).colorScheme(.dark)
    }
}
