//
//  WeatherManager.swift
//  WeatherNow
//
//  Created by Yevhenii Vladichuk on 06/03/2023.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1aa1e08139c8e72a479ee95dee05daf6&units=metric"
    
    func fetchWeather(cityName: String) {
        let city = cityName.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. create a URL
        if let url = URL(string: urlString) {
            //2. create a URL session
            let session = URLSession(configuration: .default)
            
            //3. give the session a task
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data)-> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let decodeID = decodeData.weather[0].id
            let decodeName = decodeData.name
            let decodeTemp = decodeData.main.temp
            
            let weatherModel = WeatherModel(conditionID: decodeID, temperature: decodeTemp, cityName: decodeName)
            
            return weatherModel
        }catch {
            delegate?.didFailWithError(error: error )
            return nil
        }
    }
}
