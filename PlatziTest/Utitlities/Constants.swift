//
//  Constants.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 06/03/21.
//

import Foundation
import UIKit

struct Fonts {
    static let defaultFont: UIFont = {
        return UIFont.systemFont(ofSize: 12)
    }()
    
    static let captionOne: UIFont = {
        guard let font = UIFont(name: "HelveticaNeue-Bold", size: 16) else { return Fonts.defaultFont }
        return font
    }()
    
    static let captionTwo: UIFont = {
        guard let font = UIFont(name: "Helvetica Neue", size: 12) else { return Fonts.defaultFont }
        return font
    }()
    
    static let bodyOne: UIFont = {
        guard let font = UIFont(name: "Helvetica Neue", size: 14) else { return Fonts.defaultFont }
        return font
    }()
    
    static let ratingRegular: UIFont = {
        guard let font = UIFont(name: "ChalkboardSE-Regular", size: 16) else { return Fonts.defaultFont }
        return font
    }()
    
    static let ratingSuperscript: UIFont = {
        guard let font = UIFont(name: "ChalkboardSE-Regular", size: 6) else { return Fonts.defaultFont }
        return font
    }()
}

struct Colors {
    static let border: UIColor = UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1.0)
    static let primaryWhite: UIColor = UIColor(red: 205/255.0, green: 205/255.0, blue: 205/255.0, alpha: 1.0)
    static let backgroundFaded: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
    static let lightGray: UIColor = UIColor(red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1.0)
    static let header: UIColor = UIColor(red: 252/255.0, green: 208/255.0, blue: 82/255.0, alpha: 1.0)
    static let background: UIColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1.0)
    static let green: UIColor = UIColor(red: 98/255.0, green: 205/255.0, blue: 130/255.0, alpha: 1.0)
    static let yellow: UIColor = UIColor(red: 210/255.0, green: 213/255.0, blue: 83/255.0, alpha: 1.0)
    static let darkGreen: UIColor = UIColor(red: 41/255.0, green: 68/255.0, blue: 43/255.0, alpha: 1.0)
    static let darkYellow: UIColor = UIColor(red: 65/255.0, green: 62/255.0, blue: 23/255.0, alpha: 1.0)
}
