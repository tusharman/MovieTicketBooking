//
//  NetworkManagerFactory.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import Foundation

class NetworkManagerFactory {
    static func createNetworkManager() -> NetworkManagerProtocol {
        return MockNetworkManager()
    }
}
