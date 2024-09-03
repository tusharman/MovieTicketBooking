//
//  Languages.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import Foundation

struct Languages : Codable {
    let language : String?
    let potraitPoster : String?
    let landscapePoster : String?
    let filmFormats : [String]?
    let posMovieId : [String]?
    let trailerLink : String?
    let releaseDate : String?

    enum CodingKeys: String, CodingKey {
        case language = "language"
        case potraitPoster = "potraitPoster"
        case landscapePoster = "landscapePoster"
        case filmFormats = "filmFormats"
        case posMovieId = "PosMovieId"
        case trailerLink = "trailerLink"
        case releaseDate = "releaseDate"
    }
}
