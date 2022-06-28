//
//  UIFont+Roboto.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 28/06/22.
//

import Foundation
import UIKit

public enum FontRobotoStyle: String {
    case bold
    case light
    case medium
    case regular

    func fontName() -> String {
        switch self {
        case .light:
            return "Roboto-Light"
        case .regular:
            return "Roboto-Regular"
        case .medium:
            return "Roboto-Medium"
        case .bold:
            return "Roboto-Bold"
        }
    }

    func fontFilename() -> String {
        switch self {
        case .light:
            return "Roboto-Light"
        case .regular:
            return "Roboto-Regular"
        case .medium:
            return "Roboto-Medium"
        case .bold:
            return "Roboto-Bold"
        }
    }

    func fontFamilyName() -> String {
        switch self {
        case .light:
            return "Roboto-Light"
        case .regular:
            return "Roboto-Regular"
        case .medium:
            return "Roboto-Medium"
        case .bold:
            return "Roboto-Bold"
        }
    }
}

extension UIFont {
    class func fontRoboto(size: CGFloat, style: FontRobotoStyle) -> UIFont {
        guard let customFont = UIFont(name: style.fontFamilyName(), size: size) else {
            return UIFont.systemFont(ofSize: size)
          }
          return customFont
    }
}
