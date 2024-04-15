//
//  Cityview.swift
//  WhetherNow
//
//  Created by runku shanth kumar on 11/04/24.
//


import Foundation
import SwiftUI

struct WeatherDayView: View {
    @State private var searchCity = false
    @State var weather: ResponseBody?
    @StateObject private var whetherViewModel = WheaterViewModel()
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                HStack {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(whetherViewModel.responseBody.name)
                            .bold()
                            .font(.title)
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .fontWeight(.light)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Button {
                        searchCity = true
                    } label: {
                        Text(whetherViewModel.searchString)
                            .font(.headline)
                    }
                }
                Spacer()
                
                VStack(spacing: 0.0) {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "cloud")
                                .font(.system(size: 40))
                            
                            Text("\(whetherViewModel.responseBody.weather[0].main)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text((whetherViewModel.responseBody.main.feelsLike.roundDouble()) + "°")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .padding()
                    }
                    VStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Text(whetherViewModel.whetherNowString)
                                .bold()
                                .padding(.bottom)
                            
                            HStack {
                                WeatherRow(logo: "thermometer", name: "Min temp", value: (whetherViewModel.responseBody.main.tempMin.roundDouble() + ("°")))
                                Spacer()
                                WeatherRow(logo: "thermometer", name: "Max temp", value: (whetherViewModel.responseBody.main.tempMax.roundDouble() + "°"))
                            }
                            
                            HStack {
                                WeatherRow(logo: "wind", name: "Wind speed", value: (whetherViewModel.responseBody.wind.speed.roundDouble() + " m/s"))
                                Spacer()
                                WeatherRow(logo: "humidity", name: "Humidity", value: "\(whetherViewModel.responseBody.main.humidity.roundDouble())%")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 20)
                        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                        .background(.white)
                        .cornerRadius(20)
                    }
                    Spacer()
                    HStack {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                                ForEach(whetherViewModel.responseBodyListData, id: \.self) { row in
                                    WeatherDayViewFuture(dayOfWeek: row.dtTxt?.dateToDayName() ?? "", imageName: "cloud.sun.fill", temperature: row.main?.feelsLike?.roundDouble() ?? "")
                                }
                            }
                        }
                        .frame(height: 300)
                    }
                    .frame(height: 300)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
        .sheet(isPresented: $searchCity, content: {
            SearchView(whetherViewModel: whetherViewModel, searchCity: $searchCity)
        })
    }
}
    
    struct WeatherRow: View {
        var logo: String
        var name: String
        var value: String
        
        var body: some View {
            HStack(spacing: 20) {
                Image(systemName: logo)
                    .font(.title2)
                    .frame(width: 20, height: 20)
                    .padding()
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                    .cornerRadius(50)

                
                VStack(alignment: .leading, spacing: 8) {
                    Text(name)
                        .font(.caption)
                    
                    Text(value)
                        .bold()
                        .font(.title)
                }
            }
        }
    }


struct WeatherDayViewFuture: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: String
    
    var body: some View {
        VStack {
            Text (dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                . foregroundColor(.white)
            Image (systemName: imageName)
                .renderingMode(.original)
                .resizable ()
                .aspectRatio(contentMode: .fit)
                . frame(width: 40, height: 40)
            Text ("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                . foregroundColor(.white)
        }
    }
    
}


#Preview {
 WeatherDayView(weather: previewWeather)
}

