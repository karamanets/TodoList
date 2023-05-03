//
//  DataManagerList.swift
//  TodoList
//
//  Created by Alex Karamanets on 18.04.2023.
//

import CoreData

protocol DataManagerCRUDProtocol {
    
    func saveData(description: String)
    func getData() -> [Todo]
    func deleteData(uuid: String)
    func updateData(uuid: String, title: String)
}

