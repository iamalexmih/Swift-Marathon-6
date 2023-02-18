//
//  WeatherModel.swift
//  Clima
//
//  Created by Алексей Попроцкий on 18.02.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel: Decodable {
    let name: String?
    let main: Main?
    let weather: [Weather]?
}


struct Main: Decodable {
    let temp: Double?
}


struct Weather: Decodable {
    let description: String?
}
