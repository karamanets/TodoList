//
//  Values.swift
//  TodoList
//
//  Created by Alex Karamanets on 18.04.2023.
//

import UIKit

enum ViewValues {
    
    /// Size's
    static let height    : CGFloat = 55
    static let topPadding: CGFloat = 36
    static let padding   : CGFloat = 15
    static let font      : CGFloat = 25
    static let zero      : CGFloat = 0
    static let one       : CGFloat = 1
    static let alpha     : CGFloat = 0.5
    
    /// empty
    static let empty = ""
    
    /// Text
    static let logo    = "Todo List 🥳"
    static let addLogo = "Add some task 🖋️"
    
    /// Button add controller name
    static let buttonName = "Save"
    
    /// Button list controller image
    static let imagePlus = UIImage(systemName: "plus")
    
    /// Colors
    static let myColor = UIColor(named: "myColor")
    static let color   = UIColor.systemPurple
}
