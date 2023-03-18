//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       animateLabelTitle()
    }
    

    // анимация без фрейворка CLTypingLabel
    private func animateLabelTitle() {
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "😎FlashChat"
        for letter in titleText {
            print("-")
            print(0.1 * charIndex)
            print(letter)
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { [weak self] timer in
                guard let self = self else { return }
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
}
