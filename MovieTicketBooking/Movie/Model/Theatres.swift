//
//  Theatres.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.

import Foundation
struct Theatres : Codable {
    let _id : String?
    let posCityID : String?
    let posTheatreID : String?
    let theatreName : String?
    let address1 : String?
    let address2 : String?
    let lat : String?
    let long : String?
    let isOnline : String?
    let imagesArr : [String]?
    let galleryArr : [String]?

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case posCityID = "PosCityID"
        case posTheatreID = "PosTheatreID"
        case theatreName = "TheatreName"
        case address1 = "Address1"
        case address2 = "Address2"
        case lat = "Lat"
        case long = "Long"
        case isOnline = "IsOnline"
        case imagesArr = "ImagesArr"
        case galleryArr = "GalleryArr"
    }
}
