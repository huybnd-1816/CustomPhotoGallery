//
//  UIView+.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/18/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    // Flash Animation Camera
    func flashAnimation() {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveLinear], animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func fadeIn(duration: TimeInterval = 0.2,
                delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseIn,
                       animations: {
                        self.alpha = 1.0
        }, completion: nil)
    }
    
    func fadeOut(duration: TimeInterval = 0.2,
                 delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseIn,
                       animations: {
                        self.alpha = 0.0
        }, completion: nil)
    }
}
