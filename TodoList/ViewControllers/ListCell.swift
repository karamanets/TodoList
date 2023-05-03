//
//  ListCell.swift
//  TodoList
//
//  Created by Alex Karamanets on 17.04.2023.
//

import UIKit

final class ListCell: UITableViewCell {
    
    //MARK: Public
    public func configure(with title: String) {
        label.text = title
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) ListCell has not been implemented")
    }
    
    //MARK: Private property
    private let randomColor = RandomColor().color
    private let values = ViewValues.self
    private lazy var label: UILabel = {
        let label = UILabel()
        if #available(iOS 16.0, *) {
            label.font = UIFont.systemFont(ofSize: values.font, weight: .heavy, width: .compressed)
        } else {
            label.font = .systemFont(ofSize: values.font)
        }
        label.textColor = UIColor.theme.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

//MARK: Private methods
private extension ListCell {
    
    func initialize() {
        backgroundColor = randomColor.withAlphaComponent(values.alpha)
        
        addSubview(label)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: values.padding).isActive = true
    }
}
