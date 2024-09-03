//
//  Schedules.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import Foundation
struct Schedules : Codable {
    let day : String?
    let showTimings : [[String?]]

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case showTimings = "showTimings"
    }
}
