//
//  AddCityView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct AddCityView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject
    var userSettings: UserSettings
    
    @ObservedObject
    var viewModel = AddCityViewModel()

    var body: some View {
        VStack {
            Spacer()
            
            if (!viewModel.cityName.isEmpty) {
                CityView(currentWeather: viewModel.currentWeather)
                    .frame(height: 150)
                    .padding(.bottom, 20)
            }
            
            VStack {
                TextField("Enter cite name", text: $viewModel.cityName)
                    .padding(.top, 10)
                    .padding()
                Divider()
                    
                Button(action: {
                    userSettings.addCity(cityName: viewModel.currentWeather.cityName)
                    presentation.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Add City")
                        Spacer()
                    }
                })
                .disabled(viewModel.currentWeather.weather == nil)
                .padding()
            }
            .padding(.horizontal)
            .background(Color(.systemBackground))
            .cornerRadius(10)

            Spacer()
            
        }
        .animation(.easeInOut)
        .padding()
        .font(.title3)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }

}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView(userSettings: UserSettings())
    }
}
