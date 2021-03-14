//
//  CurrentWeatherDetailsView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct CurrentWeatherDetailsView: View {
    
    var currentWeather: СityCurrentWeather?
    
    init(from currentWeather: СityCurrentWeather? = nil) {
        self.currentWeather = currentWeather
    }

    var body: some View {
        VStack(spacing: -5) {
            header
            Spacer()
            footer
        }
        .animation(.easeInOut)
        .foregroundColor(.white)
        .padding(20)
        .background(Color.blue)
        .cornerRadius(10)
    }

}

private extension CurrentWeatherDetailsView {
    
    var cityText: some View {

        let cityText = currentWeather?.city ?? "City"

        return Text(cityText)
            .font(.title3)
    }
    
    var icon: some View {
        Image(systemName: "cloud.rain.fill")
            .font(.title2)
    }
    
    var header: some View {
        HStack() {
            cityText
            Spacer()
            icon
        }
    }
    
    var temperatureText: some View {

        let temperature = Int(currentWeather?.main.temperature ?? 0)

        return Text("\(temperature)°")
            .font(.system(size: 40, weight: .medium, design: .rounded))
    }
    
    var weatherDescription: some View {

        let desription = currentWeather?.weather.first?.main ?? "Desc"
        
        return Text(desription)
    }
    
    var highestTemperatureText: some View {
        
        let highestTemperature = Int(currentWeather?.main.maximumTemperature ?? 0)
        
        return Text("H:\(highestTemperature)°")
    }
    
    var lowestTemperatureText: some View {
        
        let lowestTemperature = Int(currentWeather?.main.minimumTemperature ?? 0)
        
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
    
}

struct CurrentWeatherDetailsView_Previews: PreviewProvider {
    
    static var currentWeatherMock = СityCurrentWeather(
        dateTime: 0,
        weather: [.init(identifier: 1,
                       main: "Rain",
                       description: "Light Rain",
                       icon: "01d")],
        main: .init(temperature: 10,
                    minimumTemperature: 8,
                    maximumTemperature: 15),
        city: "Kyiv")
    
    static var previews: some View {
        CurrentWeatherDetailsView(from: currentWeatherMock)
            .frame(width: 200, height: 100, alignment: .center)
        
        CurrentWeatherDetailsView(from: currentWeatherMock)
            .redacted(reason: .placeholder)
            .frame(width: 200, height: 100, alignment: .center)
    }
}
