//
//  CGColor+Random.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 28/06/22.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...0.7),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
