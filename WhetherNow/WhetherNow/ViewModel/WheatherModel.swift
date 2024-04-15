//
//  WhetherModel.swift
//  WhetherNow
//
//  Created by runku shanth kumar on 11/04/24.
//

import Foundation
import Combine
import CoreLocation


class WheaterViewModel: ObservableObject {
    
    public let todayString = "Today"
    public let searchString = "Search"
    public let asyncImageString = "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png"
    public let whetherNowString = "Weather now"

    @Published public var responseBody: ResponseBody = previewWeather
    @Published public var responseBodyListData: [ListData] = [ListData]()
    
    public func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        // Replace YOUR_API_KEY in the link below with your own
        //    "
        let wheatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=48532a5e16bd27acbb55cf0c9b778afc&units=metric"
        guard let url = URL(string: wheatherURL) else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        self.responseBody = decodedData
        
        return decodedData
    }
    
    public func getNextThreeDaysWhether(zip: String, countryCode: String) async throws -> ResponseBodyList {
        // Replace YOUR_API_KEY in the link below with your own
        let wheatherURL =  "https://api.openweathermap.org/data/2.5/forecast/daily?zip=\(zip),\(countryCode)&appid=48532a5e16bd27acbb55cf0c9b778afc&cnt=40&units=metric"
        guard let url = URL(string: wheatherURL) else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBodyList.self, from: data)
        
        if  let futureDays = decodedData.list?.filter({ $0.dtTxt?.dateTo() ?? Date() > Date.now}) {
            self.responseBodyListData = futureDays
        }
        do {
            let loaded = try JSONDecoder().decode(ResponseBodyList.self, from: data)
            print(loaded)
            /* *//* return loaded*/
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
        return decodedData
    }
    
    
    
}


// Extension for rounded Double to 0 decimals
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension String {
    func dateTo() -> Date {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withFullDate] // Added format options
            let date = dateFormatter.date(from: self) ?? Date.now
            return date
        }
    
    func dateToDayName() -> String {
        let date  = self.dateTo()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
}
