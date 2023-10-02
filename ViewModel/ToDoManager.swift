//
//  ToDoManager.swift
//  day-assistant
//
//  Created by Kun Chen on 2023-09-29.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ToDoManager: ObservableObject {
    private var db = Firestore.firestore()
    @Published var toDoItems: [ToDoItem] = []

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("toDoItems").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.toDoItems = documents.map { queryDocumentSnapshot -> ToDoItem in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let category = data["category"] as? String ?? ""
                let details = data["details"] as? String ?? ""
                let completed = data["completed"] as? Bool ?? false
                
                return ToDoItem(id: id, category: category, details: details, completed: completed)
            }
        }
    }

    func add(item: ToDoItem) {
        var itemToAdd = item
        let newDocumentRef = db.collection("toDoItems").addDocument(data: itemToAdd.toDictionary())
        itemToAdd.id = newDocumentRef.documentID
    }

    
    func remove(at index: Int) {
        if index < toDoItems.count && index >= 0 {
            if let idToDelete = toDoItems[index].id {
                print(idToDelete)
                db.collection("toDoItems").document(idToDelete).delete()
            }
        }
    }
    
    func toggleCompletion(at index: Int) {
        if index < toDoItems.count && index >= 0 {
            if let idToToggle = toDoItems[index].id {
                let completed = toDoItems[index].completed
                print(completed)
                db.collection("toDoItems").document(idToToggle).updateData(["completed" : completed])
            }
        }
    }
}

extension ToDoItem {
    func toDictionary() -> [String: Any] {
        return [
            "category": category,
            "details": details,
            "completed": completed
        ]
    }
}
