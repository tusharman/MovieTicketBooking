//
//  MovieInfo.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

struct MovieInfo : Codable {
    let movieDetails : [MovieDetails]?
    let schedules : [Schedules]?
    let theatres : [Theatres]?

    enum CodingKeys: String, CodingKey {
        case movieDetails = "movieDetails"
        case schedules = "schedules"
        case theatres = "theatres"
    }
}
