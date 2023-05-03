//
//  Colors.swift
//  TodoList
//
//  Created by Alex Karamanets on 03/05/2023.
//

import UIKit

extension UIColor {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    
    let main = UIColor(named: "myColor")          ?? .systemPurple
    let background = UIColor(named: "background") ?? .systemGroupedBackground
    let textColor = UIColor(named: "textColor")   ?? .systemGroupedBackground
}
