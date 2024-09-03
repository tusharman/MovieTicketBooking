//
//  NetworkManagerProtocol.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
