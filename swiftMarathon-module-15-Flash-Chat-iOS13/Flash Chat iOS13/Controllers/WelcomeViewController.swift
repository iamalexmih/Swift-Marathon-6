//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

//    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLabelTitleNew()
//       animateLabelTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        // скрыть панель навигации
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Показать панель навигации. Если этого не сделать, то у всех следующих экранов панель будет скрыта
        navigationController?.isNavigationBarHidden = false
    }
    
    
    private func animateLabelTitleNew() {
        titleLabel.text = "😎FlashChat"
    }

    // анимация без фрейворка CLTypingLabel
    private func animateLabelTitle() {
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "😎 FlashChat"
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
