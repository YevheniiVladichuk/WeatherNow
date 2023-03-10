//
//  WeatherModel.swift
//  WeatherNow
//
//  Created by Yevhenii Vladichuk on 09/03/2023.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let temperature: Double
    let cityName: String
    
    var tempString: String {
        return String(format: "%.0f", temperature)
    }
    
    var weatherCondition: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow.fill"
        case 701...741:
            return "smoke.circle"
        case 751...781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.fill"
        default:  return "sun.max.trianglebadge.exclamationmark.fill"
        }
    }
}
