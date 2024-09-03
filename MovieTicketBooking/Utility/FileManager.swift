//
//  FileManager.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import Foundation

final class FileManager {
   static func readFile(_ name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
