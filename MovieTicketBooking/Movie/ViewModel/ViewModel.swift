//
//  ViewModel.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import Foundation
import CoreLocation

final class ViewModel {
    var movieInfo: MovieInfo?
    var selectedTheatre: Theatres?
    var selectedMovie: MovieDetails?
    var moviesForTheater: [MovieDetails] = []
    var datesSet: Set<String> = []
    var selectedDate: String?

    var currentLatitude: CLLocationDegrees = CLLocationDegrees()
    var currentLongitude: CLLocationDegrees = CLLocationDegrees()

    init() {
        loadData()
    }

    func loadData() {
        NetworkManagerUtility.sharedInstance.fetchMovieInfo(from: URL(string: "MocKURL")!) { [weak self] result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    self?.movieInfo = try decoder.decode(MovieInfo.self, from: data)
                    // Handle successful decoding if needed
                } catch {
                    // Handle decoding error
                    print("Decoding error: \(error.localizedDescription)")
                }
            case .failure(let error):
                // Handle the error
                print("Network error: \(error.localizedDescription)")
            }
        }
    }

    func getTheaterList() -> [(String?, String?)]? {
        movieInfo?.theatres?.compactMap { ($0.theatreName, nil) }
    }

    func theaterSelectionAction(at index: Int) {
        selectedTheatre = movieInfo?.theatres?[index]
    }

    func movieSelectionAction(at index: Int) {
        selectedMovie = moviesForTheater[index]
    }

    func dateSelectionAction(at index: Int) {
        let array = Array(datesSet)
        selectedDate = array[index]
    }

    func getMovieList() -> [(String?, String?)] {
        getMoviesForTheater(theaterId: selectedTheatre?.posTheatreID ?? "2").compactMap { ($0.filmName, nil)
        }
    }


    private func getMoviesForTheater(theaterId: String) -> [MovieDetails] {
        guard let movieInfo = movieInfo,
              let schedules = movieInfo.schedules else {
            return []
        }
        for schedule in schedules {
            for showTiming in schedule.showTimings {
                // Check if the theater ID matches
                if showTiming[8] == theaterId {
                    // Find the movie details
                    if let movieId = showTiming[1],
                       !moviesForTheater.contains(where: { $0.filmcommonId == movieId }) {
                        if let movieDetail = movieInfo.movieDetails?.first(where: { $0.filmcommonId == movieId }) {
                            moviesForTheater.append(movieDetail)
                        }
                    }
                }
            }
        }
        return moviesForTheater
    }
    
    func getAvailableDateString() -> [(String?, String?)] {
        getAvailableDates(forMovieId: selectedMovie?.filmcommonId).compactMap { ($0, nil) }
    }

    private func getAvailableDates(forMovieId movieId: String?) -> [String] {
        var availableDates: Set<String> = []
        guard let movieInfo = movieInfo,
              let movieDetails = movieInfo.movieDetails else {
            return []
        }
        
        for movie in movieDetails {
            guard let schedules = movieInfo.schedules else {
                return []
            }
            // Check if the movie matches the selected ID
            if movie.filmcommonId == movieId {
                // Iterate through the schedules to collect dates
                for schedule in schedules {
                    for showTiming in schedule.showTimings {
                        if showTiming[1] == movieId,
                           let day = schedule.day {
                            availableDates.insert(day)
                        }
                    }
                }
            }
        }
        datesSet = availableDates
        return Array(availableDates).sorted()
    }

    func getAvailableShowTime() -> [(String?, String?)] {
        let dateTimeString = getAvailableShowTimes(forDate: selectedDate, movieId: selectedMovie?.filmcommonId ?? "")
        return getShowTimesIn12HourFormat(from: dateTimeString).compactMap { ($0, nil) }
    }

    private func getShowTimesIn12HourFormat(from dateTimeStrings: [String]) -> [String] {
        var showTimes: [String] = []
        
        // Define the input date-time format and output time format
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // Input format
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm a" // Output format in 12-hour format with AM/PM
        outputFormatter.amSymbol = "AM"
        outputFormatter.pmSymbol = "PM"
        outputFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
        for dateTimeString in dateTimeStrings {
            // Convert the string to a Date object
            if let date = inputFormatter.date(from: dateTimeString) {
                // Format the Date object to a string in the desired 12-hour time format
                let formattedTime = outputFormatter.string(from: date)
                showTimes.append(formattedTime)
            }
        }
        return showTimes
    }
    
    private func getAvailableShowTimes(forDate selectedDate: String?, movieId: String) -> [String] {
        var availableShowTimes: [String] = []
        guard let movieInfo = movieInfo,
              let movieDetails = movieInfo.movieDetails else {
            return []
        }
        
        for movie in movieDetails {
            guard let schedules = movieInfo.schedules else {
                return []
            }
            // Check if the movie matches the selected ID
            if movie.filmcommonId == movieId {
                // Iterate through the schedules to collect dates
                for schedule in schedules {
                    for showTiming in schedule.showTimings {
                        if showTiming[1] == movieId,
                           selectedDate == schedule.day,
                           let showTime = showTiming[2] {
                            availableShowTimes.append(showTime)
                        }
                    }
                }
            }
        }
        return availableShowTimes
    }



    func updateLocation(currentLatitude: CLLocationDegrees,
                        currentLongitude: CLLocationDegrees) {
        self.currentLatitude = currentLatitude
        self.currentLongitude = currentLongitude
    }

    func getLocationString() -> String {
        "Long: \(currentLatitude), Lat: \(currentLatitude)"
    }

    func calculateDistance(to endLatitude: String?,
                           endLongitude: String?) -> String? {
        // Create CLLocation objects for both points
        let startLocation = CLLocation(latitude: currentLatitude,
                                       longitude: currentLongitude)
        
        guard let endLat = CLLocationDegrees(endLatitude!),
              let endLong = CLLocationDegrees(endLongitude!)  else {
            return nil
        }
        let endLocation = CLLocation(latitude: endLat,
                                     longitude: endLong)
        // Calculate the distance between the two locations
        let distance = startLocation.distance(from: endLocation)
        return "\(metersToKilometers(meters: distance)) KM"
    }

    func metersToKilometers(meters: CLLocationDistance) -> Double {
        return meters / 1000.0
    }
}
