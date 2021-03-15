//
//  CurrentWeatherDetailsView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import SwiftUI

struct CityView: View {

    @Environment(\.redactionReasons) var redactionReasons

    var cityName: String
    var currentWeather: CurrentWeather?

    var body: some View {
        content
    }

}

private extension CityView {

    var cityText: some View {

        var cityName = self.cityName

        // Convert old city names and postal code to correct naming
        if let apiCityName = currentWeather?.city {
            cityName = apiCityName
        }

        return Text(cityName)
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
        HStack {
            cityText
            Spacer()
            icon
        }
    }

    var temperatureText: some View {

        let temperature = Int(currentWeather?.currentTemperature ?? 0)

        return Text("\(temperature)°")
            .font(.system(size: 40, weight: .medium, design: .rounded))
    }

    var weatherDescription: some View {

        let desription = currentWeather?.description ?? "Desc"

        return Text(desription)
    }

    var highestTemperatureText: some View {

        let highestTemperature = Int(currentWeather?.highestTemperature ?? 0)

        return Text("H:\(highestTemperature)°")
    }

    var lowestTemperatureText: some View {

        let lowestTemperature = Int(currentWeather?.lowestTemperature ?? 0)

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
        HStack {
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
        .animation(.spring())
        .redacted(reason: currentWeather == nil ? .placeholder : [])
        .animation(nil)
        // UI
        .foregroundColor(.white)
        .padding(20)
        .background(Color.blue)
        .cornerRadius(10)
        .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }

}

struct CurrentWeatherDetailsView_Previews: PreviewProvider {

    static var responceMock = CurrentWeatherResponse(
        weather: [
            .init(description: "Rain", icon: "01d")
        ],
        main: .init(temperature: 10,
                    lowestTemperature: 4,
                    highestTemperature: 12),
        city: "Kyiv")

    static var currentWeatherMock = CurrentWeather(from: responceMock)

    static var previews: some View {

        CityView(cityName: "Kyiv", currentWeather: currentWeatherMock)
            .frame(width: 200, height: 100, alignment: .center)

        CityView(cityName: "Kyiv")
            .frame(width: 200, height: 100, alignment: .center)
    }
}
