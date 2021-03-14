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
    
    @State
    private var cityName = ""

    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("Enter cite name", text: $cityName)
                    .padding()
                Button("Add") {
                    userSettings.cities.append(cityName)
                    presentation.wrappedValue.dismiss()
                }
                .padding()
            }
            .padding(.horizontal)
            .background(Color(.systemBackground))
            .cornerRadius(10)
            
            Spacer()
        }
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
