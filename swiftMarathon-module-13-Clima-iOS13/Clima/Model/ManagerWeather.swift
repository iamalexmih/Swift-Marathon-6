//
//  ManagerWeather.swift
//  Clima
//
//  Created by Алексей Попроцкий on 17.02.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManagerProtocol: AnyObject {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(with error: Error)
}


struct ManagerWeather {
    
    //    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=4e541e5f103e16c2a6499e837026a0d2&units=metric&lang=ru&lat=\(latitude.description)&lon=\(longitude.description)")!
    
    weak var delegate: WeatherManagerProtocol?
    let weatherUrlString = "https://api.openweathermap.org/data/2.5/weather?appid=4e541e5f103e16c2a6499e837026a0d2&units=metric&lang=ru"
    
    func featchWeather(_ cityName: String) {
        let urlString = "\(weatherUrlString)&q=\(cityName)"
        perfomRequest(with: urlString)
    }
    
    
    func featchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherUrlString)&lat=\(latitude.description)&lon=\(longitude.description)"
        perfomRequest(with: urlString)
    }
    
    
    func perfomRequest(with urlString: String) {
        // 1. Create URL
        guard let url = URL(string: urlString) else { return }
        
        // 2. Create URL Session
        let session = URLSession(configuration: .default)
        
        // 3. Give the sesssion a task
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "error in handle")
                delegate?.didFailWithError(with: error!)
                return
            }
            
            if let data = data {
                guard let weather = parseJSON(weatherData: data) else { return }
                delegate?.didUpdateWeather(weather)
            }
        }
        // 4. Start the task
        task.resume()
        
    }
    
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            guard let id = decodeData.weather?[0].id else {
                print("id не получен")
                return nil
            }
            guard let temp = decodeData.main?.temp else {
                print("temp не получена")
                return nil
            }
            guard let name = decodeData.name else {
                print("name не получен")
                return nil
            }
            print(123)
            let weatherModel = WeatherModel(conditionId: id,
                                            cityName: name,
                                            temperature: temp)
            return weatherModel
        } catch {
            print(error.localizedDescription)
            delegate?.didFailWithError(with: error)
            return nil
        }
    }
    
    
    
}
