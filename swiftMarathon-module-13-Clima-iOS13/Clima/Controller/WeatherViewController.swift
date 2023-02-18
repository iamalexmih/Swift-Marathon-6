//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    let managerWeather = ManagerWeather()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldDelegate()
    }

    @IBAction func searchPress(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

}


extension WeatherViewController: UITextFieldDelegate {
    
    func setupTextFieldDelegate() {
        searchTextField.delegate = self
    }
    
    
// Делегат для кнопки return на Клавиатуре
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text ?? "")
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
