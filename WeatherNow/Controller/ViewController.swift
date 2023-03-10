//
//  ViewController.swift
//  WeatherNow
//
//  Created by Yevhenii Vladichuk on 05/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
   
    let mainUI = MainUI()
    var weatherManager = WeatherManager()
    
    override func loadView() {
        super.loadView()
        view = mainUI
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        mainUI.searchField.delegate = self
        
        mainUI.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
    }

}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    @objc func searchButtonPressed(_ sender: UIButton) {
        mainUI.searchField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainUI.searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "No results"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        textField.text = ""
    }
}

// MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.mainUI.temperatureLabel.text = weather.tempString
            self.mainUI.conditionImage.image = UIImage(systemName: weather.weatherCondition)
            self.mainUI.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

