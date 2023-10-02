//
//  EventView.swift
//  AppHome
//
//  Created by Kun Chen on 2023-07-07.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct EventView: View {
    @StateObject var eventManager = EventManager()
    @State private var isLoading: Bool = true

//    let sampleEvents: [Event] = [
//        Event(id: "1", fsq_id: "fsq1", place_name: "Rock Concert", place_addr: "123 Event Street", eventTime: "5:00 PM", eventDate: "2023-10-01", cover: "https://yourwebsite.com/path_to_rock_concert.jpg", category: "Music"),
//        Event(id: "2", fsq_id: "fsq2", place_name: "Art Gallery Opening", place_addr: "456 Event Avenue", eventTime: "7:00 PM", eventDate: "2023-10-02", cover: "https://yourwebsite.com/path_to_art_gallery.jpg", category: "Arts"),
//        Event(id: "3", fsq_id: "fsq3", place_name: "Theater Play", place_addr: "789 Drama Lane", eventTime: "8:00 PM", eventDate: "2023-10-03", cover: "https://yourwebsite.com/path_to_theater_play.jpg", category: "Drama"),
//        Event(id: "4", fsq_id: "fsq4", place_name: "Food Festival", place_addr: "101 Festive Road", eventTime: "12:00 PM", eventDate: "2023-10-04", cover: "https://yourwebsite.com/path_to_food_festival.jpg", category: "Culinary"),
//        Event(id: "5", fsq_id: "fsq5", place_name: "Tech Conference", place_addr: "112 Tech Plaza", eventTime: "9:00 AM", eventDate: "2023-10-05", cover: "https://yourwebsite.com/path_to_tech_conference.jpg", category: "Tech"),
//    ]
//
//
//    func insertSampleEvents() {
//        let db = Firestore.firestore()
//
//        for event in sampleEvents {
//            do {
//                try db.collection("events").document(event.id).setData(from: event)
//            } catch let error {
//                print("Error writing event to Firestore: \(error)")
//            }
//        }
//    }

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing:10){
                Text("Events")
                    .bold()
                    .font(.headline)
            }
            
            if eventManager.isLoading {
                VStack(spacing: 20) {
                    ProgressView()  // This is the loading icon
                    Text("Loading events...")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .onAppear {
                    // Assuming you are fetching data onAppear of this EventView
                    eventManager.fetchData()
                }
            } else {
                VStack{
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(Array(eventManager.events.enumerated()), id: \.element.id) { index, event in
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(event.category)
                                        .font(.headline)
                                    HStack (spacing: 20){
                                        AsyncImage(url: URL(string: event.cover)) { phase in
                                            switch phase {
                                            case .empty:
                                                // This is where you can put your placeholder
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundColor(.gray)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                            case .failure:
                                                Image(systemName: "text.below.photo.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundColor(.gray)
                                            @unknown default:
                                                // Just in case Apple adds more cases in the future.
                                                EmptyView()
                                            }
                                        }
                                        .frame(width: 50, height: 40)
                                        .cornerRadius(8)
                                        
                                        VStack{
                                            Text(event.place_name)
                                                    .font(.body)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            Text(event.place_addr)
                                                .font(.caption)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("\(event.eventDate) at \(event.eventTime)")
                                                .font(.footnote)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        Spacer()
                                        
                                        // Delete button
                                        Button(action: {
                                            eventManager.remove(at: index)
                                        }) {
                                            Image(systemName: "delete.left.fill")
                                                .font(.system(size: 24))
                                                .foregroundColor(.gray)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            .padding([.top, .bottom], 10)
                            .cornerRadius(8)
                        }
                    }
                    .background(Color.white)
                    .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(.bottom, 10)
        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .background(.white)
        .cornerRadius(20)
//        .onAppear {
//            insertSampleEvents()
//        }

    }
}




struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
