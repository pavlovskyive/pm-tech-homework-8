//
//  CurrentWeatherDetailsView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct CityView: View {
    
    @Environment(\.redactionReasons) var redactionReasons

    var currentWeather: CityCurrentWeather

    var body: some View {
        content
    }

}

private extension CityView {
    
    var cityText: some View {

        let cityText = currentWeather.cityName

        return Text(cityText)
            .font(.title3)
            .unredacted()
    }
    
    var icon: some View {
        Image(systemName: "cloud.rain.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 25)
    }
    
    var header: some View {
        HStack() {
            cityText
            Spacer()
            icon
        }
    }
    
    var temperatureText: some View {

        let temperature = Int(currentWeather.weather?.currentTemperature ?? 0)

        return Text("\(temperature)°")
            .font(.system(size: 40, weight: .medium, design: .rounded))
    }
    
    var weatherDescription: some View {

        let desription = currentWeather.weather?.description ?? "Desc"
        
        return Text(desription)
    }
    
    var highestTemperatureText: some View {
        
        let highestTemperature = Int(currentWeather.weather?.highestTemperature ?? 0)
        
        return Text("H:\(highestTemperature)°")
    }
    
    var lowestTemperatureText: some View {
        
        let lowestTemperature = Int(currentWeather.weather?.lowestTemperature ?? 0)
        
        return Text("L:\(lowestTemperature)")
    }
    
    var boundaryTemperatures: some View {
        HStack(spacing: 3) {
            highestTemperatureText
            lowestTemperatureText
        }
        .font(.subheadline)
        .allowsTightening(true)
        .minimumScaleFactor(0.7)
    }
    
    var description: some View {
        VStack(alignment: .trailing) {
            weatherDescription
            boundaryTemperatures
        }
    }
    
    var footer: some View {
        HStack() {
            temperatureText
            Spacer()
            description
        }
    }
    
    var content: some View {

        VStack(spacing: -5) {
            header
            Spacer()
            footer
        }
        // UI
        .foregroundColor(.white)
        .padding(20)
        .background(Color.blue)
        .cornerRadius(10)
        .animation(nil)
        // Appearing animation
        .opacity(redactionReasons == .placeholder ? 0.7 : 1)
        .animation(.easeInOut)
    }
    
}

struct CurrentWeatherDetailsView_Previews: PreviewProvider {
    
    static var currentWeatherMock = CityCurrentWeather(cityName: "Kyiv")
    
    static var previews: some View {
        
        CityView(currentWeather: currentWeatherMock)
            .frame(width: 200, height: 100, alignment: .center)
            .redacted(reason: [])
        
        CityView(currentWeather: currentWeatherMock)
            .redacted(reason: .placeholder)
            .frame(width: 200, height: 100, alignment: .center)
    }
}
