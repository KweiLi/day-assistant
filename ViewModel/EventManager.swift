//
//  EventManager.swift
//  day-assistant
//
//  Created by Kun Chen on 2023-10-02.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventManager: ObservableObject {
    @Published var events: [Event] = []
    private var db = Firestore.firestore()
    @Published var isLoading: Bool = true

    init() {
        fetchData()
    }

    func fetchData() {
        isLoading = true
        db.collection("events").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No data fetched: \(error?.localizedDescription ?? "Unknown error")")
                self.isLoading = false
                return
            }
            
            self.events = documents.compactMap { queryDocumentSnapshot -> Event? in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                
                // Convert the Firestore document data to Event object
                guard let fsq_id = data["fsq_id"] as? String,
                      let place_name = data["place_name"] as? String,
                      let place_addr = data["place_addr"] as? String,
                      let eventTime = data["eventTime"] as? String,
                      let eventDate = data["eventDate"] as? String,
                      let cover = data["cover"] as? String,
                      let category = data["category"] as? String else {
                    return nil
                }
                
                return Event(id: id, fsq_id: fsq_id, place_name: place_name, place_addr: place_addr, eventTime: eventTime, eventDate: eventDate, cover: cover, category: category)
            }
            self.isLoading = false
        }
    }

    func remove(at index: Int) {
        if index < events.count && index >= 0 {
            let idToDelete = events[index].id
            db.collection("events").document(idToDelete).delete()
        }
    }
}

