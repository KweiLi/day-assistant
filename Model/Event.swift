//
//  EventModel.swift
//  AppHome
//
//  Created by Kun Chen on 2023-07-07.
//

import Foundation
import SwiftUI

struct Event: Identifiable, Equatable, Hashable, Codable {
    var id: String
    let fsq_id: String
    let place_name: String
    let place_addr: String
    let eventTime: String
    let eventDate: String
    let cover: String
    let category: String
}
