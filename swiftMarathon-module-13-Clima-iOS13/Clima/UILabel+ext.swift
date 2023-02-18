//
//  UILabel+ext.swift
//  Clima
//
//  Created by Алексей Попроцкий on 18.02.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit


extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
      }
}
