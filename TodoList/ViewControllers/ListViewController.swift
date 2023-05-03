//
//  ViewController.swift
//  TodoList
//
//  Created by Alex Karamanets on 17.04.2023.
//

import UIKit
import Combine

final class ListViewController: UITableViewController {
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: Init
    init(dataManager: DataManagerCRUDProtocol) {
        self.dataManager = dataManager
        super.init(style: .insetGrouped) /// style for TableView because it a UITableViewController
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Privet property
    private lazy var addButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = values.imagePlus
        config.cornerStyle = .capsule
        config.buttonSize = .large
        config.baseBackgroundColor = values.myColor ?? values.color
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config, primaryAction: addButtonAction())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var listTodo = [Todo]()
    private var cancelable = Set<AnyCancellable>()
    private let values = ViewValues.self
    private let dataManager: DataManagerCRUDProtocol
}

//MARK: Private methods
private extension ListViewController {
        
    func initialize() {
        view.backgroundColor = UIColor.theme.background
        title = values.logo
        
        listTodo = dataManager.getData()
        
        tableView.register(ListCell.self, forCellReuseIdentifier: String(describing: ListCell.self))
        
        guard let nav = navigationController else { return }
        nav.navigationBar.prefersLargeTitles = true
        nav.view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: nav.view.safeAreaLayoutGuide.trailingAnchor, constant: -values.padding),
            addButton.bottomAnchor.constraint(equalTo: nav.view.safeAreaLayoutGuide.bottomAnchor, constant: -values.padding)
        ])
    }
    
    func reloadData() {
        self.listTodo = self.dataManager.getData()
        self.tableView.reloadData()
    }
    
    func addButtonAction() -> UIAction {
        ///Button for add item
        let action = UIAction { _ in
            let controller = AddTodoViewController()
            controller.newTodo.sink { [weak self] todoTitle in
                
                guard let self = self else { return }
                
                self.dataManager.saveData(description: todoTitle)
                self.reloadData()
                
            }.store(in: &self.cancelable)
            
            let nav = UINavigationController(rootViewController: controller)
            self.present(nav, animated: true)
        }
        return action
    }
}

//MARK: TableView
extension ListViewController {
    
    /// Number of section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listTodo.count
    }

    /// SetUp for cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListCell.self), for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        let todo = listTodo[indexPath.section]
        cell.configure(with: todo.title ?? "")
        return cell
    }
    
    /// delete data and section
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todo = listTodo[indexPath.section]
            let id = todo.id?.uuidString ?? values.empty
            dataManager.deleteData(uuid: id)
            listTodo.remove(at: indexPath.section)
            
            let index = IndexSet(arrayLiteral: indexPath.section)
            tableView.beginUpdates()
            tableView.deleteSections(index, with: .left)
            tableView.endUpdates()
        }
    }
    
    /// Update row on press
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = listTodo[indexPath.section]
        let id = todo.id?.uuidString ?? values.empty
        let controller = AddTodoViewController(description: todo.title ?? values.empty)
        controller.newTodo.sink { [weak self] todoTitle in
            
            guard let self = self else { return }
            
            self.dataManager.updateData(uuid: id, title: todoTitle)
            self.reloadData()
            
        }.store(in: &self.cancelable)
        
        let nav = UINavigationController(rootViewController: controller)
        self.present(nav, animated: true)
    }
    
    /// Number of row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(values.one)
    }
    
    /// height between section
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return values.padding
    }
    
    /// Turn off - viewForFooter,  viewForHeader and make hight for heightForHeaderInSection  = 0. Can control hight between section ->  heightForFooterInSection
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return values.zero
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

