//
//  ViewController.swift
//  WeatherNow
//
//  Created by Yevhenii Vladichuk on 05/03/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let mainUI = MainUI()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    let spiner = UIActivityIndicatorView()
    
    override func loadView() {
        super.loadView()
        view = mainUI
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegateSpinner = self
        weatherManager.delegate = self
        mainUI.searchField.delegate = self
        
        locationManager.delegate = self
        showActivityIndicator()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        mainUI.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        mainUI.locationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
        print("The user did not enter a city name.")
    }
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    @objc func locationButtonPressed(_ sender: UIButton) {
        showActivityIndicator()
        mainUI.searchField.endEditing(true)
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - SpinnerManagerDelegate

extension ViewController: SpinnerManagerDelegate {
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.spiner.stopAnimating()
            self.spiner.hidesWhenStopped = true
        }
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.spiner.style = .large
            self.spiner.color = UIColor(named: "MyWeatherColor")
            self.view.addSubview(self.spiner)
            self.spiner.center = self.view.center
            self.spiner.startAnimating()
        }
    }
}
