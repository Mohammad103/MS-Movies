//
//  UIColor+Utilities.swift
//  MS Movies
//
//  Created by Mohammad Shaker on 9/2/18.
//  Copyright © 2018 Mohammad Shaker. All rights reserved.
//

import UIKit

extension UIColor {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
