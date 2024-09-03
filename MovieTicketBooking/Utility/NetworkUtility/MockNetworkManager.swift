//
//  MockNetworkManager.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    var mockData: Data?
    var mockError: Error?
    
    func fetchData(from url: URL, 
                   completion: @escaping (Result<Data, Error>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
            return
        }
        
        if let data = mockData {
            completion(.success(data))
            return
        }
        
        let error = NSError(domain: "MockError", 
                            code: 0, userInfo: [NSLocalizedDescriptionKey: "No mock data available"])
        completion(.failure(error))
    }
}
