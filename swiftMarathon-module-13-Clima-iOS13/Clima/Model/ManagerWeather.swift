//
//  ManagerWeather.swift
//  Clima
//
//  Created by Алексей Попроцкий on 17.02.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


struct ManagerWeather {
    
    //    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longitude.description)&units=metric&lang=ru&appid=4e541e5f103e16c2a6499e837026a0d2")!
    
    
    let weatherUrlString = "https://api.openweathermap.org/data/2.5/weather?appid=4e541e5f103e16c2a6499e837026a0d2&units=metric&lang=ru"
    
    func featchWeather(_ cityName: String) {
        let urlString = "\(weatherUrlString)&q=\(cityName)"
    }
    
    
    func perfomRequest(urlString: String) {
        // 1. Create URL
        guard let url = URL(string: urlString) else { return }
        
        // 2. Create URL Session
        let session = URLSession(configuration: .default)
        
        // 3. Give the sesssion a task
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "error in handle")
                return
            }
            
            if let data = data {
                parseJSON(weatherData: data)
            }
        }
        
        // 4. Start the task
        task.resume()
        
    }
    
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherModel.self, from: weatherData)
        } catch {
            print(error.localizedDescription)
        }
    }
}
