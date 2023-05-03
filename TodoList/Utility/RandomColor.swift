//
//  RandomColor.swift
//  TodoList
//
//  Created by Alex Karamanets on 17.04.2023.
//

import UIKit

struct RandomColor {
    
    //MARK: Public
    public var color: UIColor {
        return currentColor
    }
    
    //MARK: Init
    init() { currentColor = getRandomColor() }
    
    //MARK: Private
    private let colors: [UIColor] = [.brown, .purple, .systemPink, .magenta, .blue, .orange]
    private var currentColor = UIColor()
    private func getRandomColor() -> UIColor {
        let index = Int.random(in: 0..<colors.count)
        return colors[index]
    }
}
