//
//  MovieDetails.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import Foundation
struct MovieDetails : Codable {
    let filmcommonId : String?
    let filmName : String?
    let pGRating : String?
    let runTime : String?
    let filmGenre : String?
    let filmStatus : String?
    let castCrew : String?
    let director : String?
    let synopsis : String?
    let movieIds : [[String]]?
    let languages : [Languages]?

    enum CodingKeys: String, CodingKey {
        case filmcommonId = "filmcommonId"
        case filmName = "filmName"
        case pGRating = "PGRating"
        case runTime = "runTime"
        case filmGenre = "filmGenre"
        case filmStatus = "filmStatus"
        case castCrew = "castCrew"
        case director = "director"
        case synopsis = "synopsis"
        case movieIds = "movieIds"
        case languages = "languages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        filmcommonId = try values.decodeIfPresent(String.self, forKey: .filmcommonId)
        filmName = try values.decodeIfPresent(String.self, forKey: .filmName)
        pGRating = try values.decodeIfPresent(String.self, forKey: .pGRating)
        runTime = try values.decodeIfPresent(String.self, forKey: .runTime)
        filmGenre = try values.decodeIfPresent(String.self, forKey: .filmGenre)
        filmStatus = try values.decodeIfPresent(String.self, forKey: .filmStatus)
        castCrew = try values.decodeIfPresent(String.self, forKey: .castCrew)
        director = try values.decodeIfPresent(String.self, forKey: .director)
        synopsis = try values.decodeIfPresent(String.self, forKey: .synopsis)
        movieIds = try values.decodeIfPresent([[String]].self, forKey: .movieIds)
        languages = try values.decodeIfPresent([Languages].self, forKey: .languages)
    }

}
