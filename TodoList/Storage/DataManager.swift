//
//  DataManager.swift
//  TodoList
//
//  Created by Alex Karamanets on 18.04.2023.
//

import UIKit
import CoreData

final class DataManager {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

extension DataManager: DataManagerCRUDProtocol {
    
    func saveData(description: String) {
        let todo = Todo(context: context)
        todo.title = description
        todo.id = UUID()
        do {
            try context.save()
        } catch let error {
            print("Error saving Data: \(error.localizedDescription)")
        }
    }
    
    func getData() -> [Todo] {
        let fetchListRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        var lists = [Todo]()
        do {
            lists = try context.fetch(fetchListRequest)
        } catch let error {
            print("Error fetching Data: \(error.localizedDescription)")
        }
        return lists
    }
    
    func deleteData(uuid: String) {
        fetchRequest(uuid: uuid) { [weak self] todo in
            guard let self = self else { return }
            do {
                self.context.delete(todo)
                try self.context.save()
            } catch let error {
                print("Error delete : \(error.localizedDescription)")
            }
        }
    }
    
    func updateData(uuid: String, title: String) {
        fetchRequest(uuid: uuid) { [weak self] todo in
            guard let self = self else { return }
            do {
                todo.title = title
                try self.context.save()
            } catch let error {
                print("Error delete : \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchRequest(uuid: String, completion: @escaping (Todo) -> Void ) {
        let fetchListRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "id == %@", uuid)
        fetchListRequest.predicate = predicate
        
        do {
            let objects  = try context.fetch(fetchListRequest)
            guard let todo = objects.first else { return }
            completion(todo)
        } catch let error {
            print("Error search: \(error.localizedDescription)")
        }
    }
    
}
