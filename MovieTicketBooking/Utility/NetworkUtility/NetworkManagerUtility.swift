//
//  NetworkManagerUtility.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import Foundation

class NetworkManagerUtility {
    static let sharedInstance = NetworkManagerUtility()
    private let networkManager = NetworkManagerFactory.createNetworkManager()
    private init() {}
    
    func fetchMovieInfo(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let jsonData = FileManager.readFile("MovieInfoDetailsJson")
        if "{\"key\":\"value\"}".data(using: .utf8) != nil {
            (networkManager as? MockNetworkManager)?.mockData = jsonData
        }
        networkManager.fetchData(from: url, completion: completion)
    }
}
