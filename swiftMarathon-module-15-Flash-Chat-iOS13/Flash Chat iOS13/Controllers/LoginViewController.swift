//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    // здесь можно поместить ошибку в лейбл или алерт, чтоб дать понять пользователю какая ошибка произошла (error.localizedDescription содержит ошибку если пароль меньше 6 символов)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue , sender: self)
                }
            }
        }
    }
    
}
