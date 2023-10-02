//
//  WeatherView.swift
//  AppHome
//
//  Created by Kun Chen on 2023-06-26.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherManager = WeatherManager()
    
    var body: some View {
        VStack {
            if let weatherResponse = weatherManager.weatherResponse {
                VStack(alignment: .leading, spacing: 20) {

                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing:10){
                            Text(weatherResponse.name)
                                .bold()
                                .font(.headline)

                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherResponse.weather.first?.icon ?? "")@2x.png")) { image in
                                // Image is successfully loaded
                                image.resizable()
                                     .scaledToFit()
                            } placeholder: {
                                // Placeholder view while the image is loading
                                ProgressView()
                            }
                            .frame(width: 40, height: 40)
                            .clipped()
                        }
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .fontWeight(.light)
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Current", value:
                                    (weatherResponse.main.temp
                                        .roundDouble() + "°"), size: 10, color: Color.purple.opacity(0.5))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Feels like", value:
                                    (weatherResponse.main.feels_like
                                    .roundDouble() + "°"), size: 10)
                    }
                    
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value:
                                    (weatherResponse.wind.speed
                                    .roundDouble() + "m/s"), size: 10)
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value:
                                    (weatherResponse.main.humidity
                                    .roundDouble() + "%"), size: 10)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20)
            } else {
                VStack(alignment: .center){
                    Text("Loading Weather...")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 20)
                        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                        .background(.white)
                        .cornerRadius(20)
                }
            }
        }
        .onAppear {
            locationManager.requestLocation()
            Task {
                if let location = locationManager.location {
                    await weatherManager.fetchWeather(at: location)
                }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
