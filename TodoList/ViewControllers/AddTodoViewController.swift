//
//  AddTodoViewController.swift
//  TodoList
//
//  Created by Alex Karamanets on 17.04.2023.
//

import UIKit
import Combine

final class AddTodoViewController: UIViewController {
    
    //MARK: Public
    public let newTodo = PassthroughSubject<String, Never>()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Init
    init(description: String = "") {
        textField.text = description /// when press on section -> able to redaction 
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private property
    private lazy var saveButton: UIButton = {
        /// configuration style for button
        var configuration = UIButton.Configuration.tinted()
        configuration.cornerStyle = .large
        configuration.baseBackgroundColor = values.color
        configuration.baseForegroundColor = values.myColor ?? values.color
        
        /// font for button
        var attribute = AttributeContainer()
        if #available(iOS 16.0, *) {
            attribute.font = UIFont.systemFont(ofSize: values.font, weight: .semibold, width: .compressed)
        } else {
            attribute.font = .systemFont(ofSize: values.font)
        }
        configuration.attributedTitle = AttributedString(values.buttonName, attributes: attribute)
        
        /// SetUp for button
        let button = UIButton(configuration: configuration, primaryAction: saveButtonAction())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 15
        textField.leftView = UIView(frame: .init(x: 0, y: 0, width: 20, height: 0))
        textField.leftViewMode = .always
        textField.placeholder = "Enter the task"
        if #available(iOS 16.0, *) {
            textField.font = UIFont.systemFont(ofSize: 25, weight: .medium, width: .compressed)
        } else {
            textField.font = .systemFont(ofSize: 25)
        }
        textField.returnKeyType = .done
        return textField
    }()
    private let values = ViewValues.self
}

//MARK: Private methods
private extension AddTodoViewController {
    
    func initialize() {
        title = values.addLogo
        view.backgroundColor = UIColor.theme.background
        textField.becomeFirstResponder()
        
        view.addSubview(textField)
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            /// TextField
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: values.padding),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -values.padding),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: values.topPadding),
            textField.heightAnchor.constraint(equalToConstant: values.height),
            
            /// Button
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: values.topPadding),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: values.padding),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -values.padding),
            saveButton.heightAnchor.constraint(equalToConstant: values.height)
        ])
        textField.delegate = self
    }
    
    /// save data with button
    func saveButtonAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            
            guard let self = self else { return }
            
            self.textField.resignFirstResponder()
            self.saveTodo()
        }
        return action
    }
    
    /// Method for save data
    func saveTodo() {
        guard let text = textField.text, text != values.empty else { return }
        newTodo.send(text)
        dismiss(animated: true) /// go back
    }
}

//MARK: TextField Delegate
extension AddTodoViewController: UITextFieldDelegate {
    
    /// save data with keyboard "DONE"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTodo()
        return true
    }
}
