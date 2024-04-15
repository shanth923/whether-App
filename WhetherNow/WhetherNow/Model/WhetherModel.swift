//
//  WhetherModel.swift
//  WhetherNow
//
//  Created by runku shanth kumar on 11/04/24.
//

import Foundation
import SwiftUI
import CoreLocation


// Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}


// MARK: - ResponseBodyList
struct ResponseBodyList: Codable {
        let cod: String?
        let message, cnt: Int?
        let list: [ListData]?
        let city: CityData?
    }

    // MARK: - City
    struct CityData: Codable {
        let id: Int?
        let name: String?
        let coord: CoordData?
        let country: String?
        let population, timezone, sunrise, sunset: Int?
    }

    // MARK: - Coord
    struct CoordData: Codable {
        let lat, lon: Double?
    }

    // MARK: - List
struct ListData: Codable, Hashable {
    static func == (lhs: ListData, rhs: ListData) -> Bool {
        return lhs.dt == rhs.dt
    }
    
        let dt: Int?
        let main: MainData?
        let weather: [WeatherData]?
        let clouds: CloudsData?
        let wind: WindData?
        let visibility, pop: Int?
        let sys: SysData?
        let dtTxt: String?

        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, visibility, pop, sys
            case dtTxt = "dt_txt"
        }
    }

    // MARK: - Clouds
    struct CloudsData: Codable,Hashable {
        let all: Int?
    }

    // MARK: - Main
    struct MainData: Codable,Hashable {
        let temp, feelsLike, tempMin, tempMax: Double?
        let pressure, seaLevel, grndLevel, humidity: Int?
        let tempKf: Double?

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
            case humidity
            case tempKf = "temp_kf"
        }
    }

    // MARK: - Sys
    struct SysData: Codable,Hashable {
        let pod: String?
    }

    // MARK: - Weather
    struct WeatherData: Codable,Hashable {
        let id: Int?
        let main, description, icon: String?
    }

    // MARK: - Wind
    struct WindData: Codable,Hashable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }



extension ResponseBody.MainResponse {
var feelsLike: Double { return feels_like }
var tempMin: Double { return temp_min }
var tempMax: Double { return temp_max }
}
