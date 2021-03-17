//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 16.03.2021.
//

import SwiftUI

struct ForecastView: View {

    @Environment(\.presentationMode)
    var presentation

    @ObservedObject
    private var viewModel: ForecastViewModel

    @Binding
    var currentWeather: CurrentWeather?

    let cityName: String

    var dayFormatter: DateFormatter
    var timeFormatter: DateFormatter

    init(cityName: String,
         currentWeather: Binding<CurrentWeather?>) {

        self.cityName = cityName
        self._currentWeather = currentWeather

        self.viewModel = .init(cityName: cityName)

        dayFormatter = .init()
        dayFormatter.dateStyle = .medium
        dayFormatter.doesRelativeDateFormatting = true

        timeFormatter = .init()
        timeFormatter.dateFormat = "H"
    }

    var body: some View {
        content
    }
}

private extension ForecastView {

    var content: some View {

        ZStack {
            header
                .offset(y: -100)

            BackgroundImage(currentWeather?.icon ?? nil)
            forecastContainer
        }
        .background(Color.blue.edgesIgnoringSafeArea(.all))
        .foregroundColor(.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear(perform: viewModel.fetchForecast)
    }

    var header: some View {

        VStack {
            Text(cityName)
                .font(.largeTitle)

            Text(currentWeather?.description ?? "")
                .font(.title2)

            Text(" \(currentWeather?.currentTemperature ?? 0)°")
                .font(.system(size: 80, design: .rounded))
        }
        .padding()
    }

    var forecastContainer: some View {

        VStack {

            Spacer()

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 50) {
                    if var forecast = viewModel.forecast {

                        ForEach(forecast.dates, id: \.self) {
                            forecastDay($0, forecast: &forecast)
                        }

                    } else {
                        loadingView
                    }
                }
                .padding(30)
            }
            .animation(.spring())
        }
    }

    func forecastDay(_ date: Date, forecast: inout Forecast) -> some View {

        VStack(alignment: .leading, spacing: 15) {

            Text(dayFormatter.string(from: date))
                .font(.subheadline)

            HStack(spacing: 20) {
                ForEach(forecast.forecastForDate(date), id: \.id) {
                    weather($0)
                }
            }
        }
    }

    var loadingView: some View {

        VStack {
            Spacer()
            Text("Loading...")
                .foregroundColor(.white)
                .opacity(0.8)
        }
        .transition(.opacity)
    }

    func weather(_ weatherData: Forecast.WeatherData) -> some View {

        VStack(spacing: 15) {

            Text(timeFormatter.string(from: weatherData.date))
                .font(.headline)
                .foregroundColor(.white)
                .opacity(0.8)

            weatherData.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)

            Text(" \(weatherData.temperature)°")
                .font(.title3)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
    }

    var backButton: some View {
        Button(action: {
            presentation.wrappedValue.dismiss()
        }, label: {
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.white)
        })
    }

}

struct ForecastView_Previews: PreviewProvider {

    static var responseMock = CurrentWeatherResponse(
        conditions: [
            .init(description: "Rain", icon: "01d")
        ],
        main: .init(temperature: 10,
                    lowestTemperature: 4,
                    highestTemperature: 12),
        city: "Kyiv")

    static var currentWeatherMock = CurrentWeather(from: responseMock)

    static var previews: some View {
        ForecastView(cityName: "Kyiv", currentWeather: .constant(currentWeatherMock))
    }
}
