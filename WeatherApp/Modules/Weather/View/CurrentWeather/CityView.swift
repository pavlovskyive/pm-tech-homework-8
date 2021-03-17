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
            .font(.title2)
            .unredacted()
            .minimumScaleFactor(0.8)
            .lineLimit(1)
    }

    var icon: some View {
        currentWeather?.icon
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30, height: 25)
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
            .minimumScaleFactor(0.8)
            .lineLimit(1)
    }

    var weatherDescription: some View {

        let desription = currentWeather?.description ?? "Desc"

        return Text(desription)
            .font(.headline)
    }

    var boundaryTemperatures: some View {

        let highestTemperature = Int(currentWeather?.highestTemperature ?? 0)
        let lowestTemperature = Int(currentWeather?.lowestTemperature ?? 0)

        return Text("H:\(highestTemperature)° L:\(lowestTemperature)")
            .font(.subheadline)
            .minimumScaleFactor(0.7)
            .lineLimit(1)
    }

    var description: some View {
        VStack(alignment: .trailing, spacing: 3) {
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

        VStack(spacing: 10) {
            header
            footer
        }
        // Placeholder
        .animation(.spring())
        .redacted(reason: currentWeather == nil ? .placeholder : [])
        // UI
        .foregroundColor(.white)
        .padding(20)
        .background(Color.blue)
        .cornerRadius(10)
        .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        // Appearing
        .animation(.easeInOut)
        .opacity(currentWeather == nil ? 0.7 : 1)
        .animation(nil)
    }

}

struct CurrentWeatherDetailsView_Previews: PreviewProvider {

    static var responceMock = CurrentWeatherResponse(
        conditions: [
            .init(description: "Rain", icon: "01d")
        ],
        main: .init(temperature: -20,
                    lowestTemperature: -25,
                    highestTemperature: -15),
        city: "Really Long City Name")

    static var currentWeatherMock = CurrentWeather(from: responceMock)

    static var previews: some View {

        CityView(cityName: "Really Long City Name", currentWeather: currentWeatherMock)
            .frame(width: 200, height: 100, alignment: .center)

        CityView(cityName: "Really Long City Name")
            .frame(width: 200, height: 100, alignment: .center)
    }
}
