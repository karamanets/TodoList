//
//  ChangeTitleColor.swift
//  TodoList
//
//  Created by Alex Karamanets on 17.04.2023.
//

import UIKit

public func changeTitleColor() {
    
    let navBarAppearance = UINavigationBar.appearance()
    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "myColor") ?? UIColor.systemPurple]
    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "myColor") ?? UIColor.systemPurple]
}
