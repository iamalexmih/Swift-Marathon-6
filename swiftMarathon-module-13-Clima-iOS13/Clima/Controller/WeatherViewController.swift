//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var managerWeather = ManagerWeather()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        managerWeather.delegate = self
        setupTextFieldDelegate()
    }

    @IBAction func searchPress(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

    
    @IBAction func weatherCurrentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}


// MARK: - Weather Manager Protocol
extension WeatherViewController: WeatherManagerProtocol {
    func didFailWithError(with error: Error) {
        
    }
    
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async { [weak self ] in
            guard let self = self else { return }
            self.temperatureLabel.fadeTransition(0.5)
            self.cityLabel.fadeTransition(0.5)
            self.conditionImageView.fadeTransition(0.5)

            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
}


// MARK: - CL Location Manager Delegate
extension WeatherViewController: CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            managerWeather.featchWeather(latitude: latitude, longitude: longitude)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


// MARK: - Text Field Delegate
extension WeatherViewController: UITextFieldDelegate {
    
    func setupTextFieldDelegate() {
        searchTextField.delegate = self
    }
    
    
// Делегат для кнопки return на Клавиатуре
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
// Делегат для действия, когда редактирование уже завершено.
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        if let city = textField.text {
            managerWeather.featchWeather(city)
        }
        textField.text = "" // по окончании редактирования очитить поле для подготовки к нового запросу
    }
    
    
// Спрашивает делегата, должно ли редактирование завершиться. Вызывается перед textFieldDidEndEditing.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
}
