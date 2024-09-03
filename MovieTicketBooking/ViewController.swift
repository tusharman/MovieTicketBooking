//
//  ViewController.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @IBOutlet private weak var theaterContainerView: UIView!
    @IBOutlet private weak var theaterDropDownView: UIView!
    @IBOutlet private weak var datesDropDownView: UIView!
    @IBOutlet private weak var datesContainerView: UIView!
    @IBOutlet private weak var moviesContainerView: UIView!
    @IBOutlet private weak var moviesDropDownView: UIView!
    @IBOutlet private weak var showTimeDropDownView: UIView!
    @IBOutlet private weak var selectMovieLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var selectedShowTimeLabel: UILabel!
    @IBOutlet private weak var selectTheaterLabel: UILabel!
    @IBOutlet private weak var selectedDateLabel: UILabel!
    @IBOutlet private weak var showTimeContainerView: UIView!
    private weak var movieDropDown: DropDownView?
    private weak var datesDropDown: DropDownView?
    private weak var showTimeDropDown: DropDownView?
    private weak var theaterDropDown: DropDownView?
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the location manager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request location permissions
        locationManager?.requestWhenInUseAuthorization()
        
        locationManager?.startUpdatingLocation()
    
        setupTheaterDropdown()
        setupMovieDropdown()
        selectMovieLabel.isEnabled = false
        selectedDateLabel.isEnabled = false
        selectedShowTimeLabel.isEnabled = false
        datesDropDownView.isHidden = true
        showTimeDropDownView.isHidden = true
        setup()
    }

    func setup() {
        theaterContainerView.layer.borderColor = UIColor.black.cgColor
        theaterContainerView.layer.borderWidth = 1
        theaterDropDown?.layer.borderColor = UIColor.black.cgColor
        theaterDropDown?.layer.borderWidth = 2
        moviesContainerView.layer.borderColor = UIColor.black.cgColor
        moviesContainerView.layer.borderWidth = 1
        moviesDropDownView.layer.borderColor = UIColor.black.cgColor
        moviesDropDownView.layer.borderWidth = 2
        datesContainerView.layer.borderColor = UIColor.black.cgColor
        datesContainerView.layer.borderWidth = 1
        datesDropDownView?.layer.borderColor = UIColor.black.cgColor
        datesDropDownView?.layer.borderWidth = 2
        showTimeContainerView?.layer.borderColor = UIColor.black.cgColor
        showTimeContainerView?.layer.borderWidth = 1
    }

    private func setupTheaterDropdown() {
        theaterDropDownView.isHidden = true
        theaterDropDown = Bundle.main.loadNibNamed("DropDownView",
                                                   owner: self,
                                                   options: nil)?.first as? DropDownView
        theaterDropDown?.frame = theaterDropDownView.bounds
        theaterDropDownView.addSubview(theaterDropDown!)
        theaterDropDown?.items = viewModel.getTheaterList()

        theaterDropDown?.onItemSelected = { [weak self] selectedItem, selectedIndex in
            self?.selectTheaterLabel.text = selectedItem
            self?.selectMovieLabel.isEnabled = true
            self?.theaterDropDownView.isHidden = true
            self?.viewModel.theaterSelectionAction(at: selectedIndex)
            self?.selectMovieLabel.isUserInteractionEnabled = true
            self?.setupMovieDropdown()
        }
        setupTheatreTapGesture()
    }
    
    private func setupMovieDropdown() {
        moviesDropDownView.isHidden = true
        movieDropDown = Bundle.main.loadNibNamed("DropDownView",
                                                 owner: self,
                                                 options: nil)?.first as? DropDownView
        movieDropDown?.frame = moviesDropDownView.bounds
        moviesDropDownView.addSubview(movieDropDown!)
        movieDropDown?.items = viewModel.getMovieList()
        movieDropDown?.onItemSelected = { [weak self] selectedItem, selectedIndex in
            self?.selectedDateLabel.isEnabled = true
            self?.selectedDateLabel.text = "Select Date"
            self?.selectedShowTimeLabel.text = "Select Show Time"
            self?.selectMovieLabel.text = selectedItem
            self?.moviesDropDownView.isHidden = true
            self?.viewModel.movieSelectionAction(at: selectedIndex)
            self?.setUpDatesDropDown()
        }
        setupMovieTapGesture()
    }

    private func setUpDatesDropDown() {
        datesDropDownView.isHidden = true
        datesDropDown = Bundle.main.loadNibNamed("DropDownView",
                                                 owner: self,
                                                 options: nil)?.first as? DropDownView
        datesDropDown?.frame = datesDropDownView.bounds
        datesDropDownView.addSubview(datesDropDown!)
        datesDropDown?.items = viewModel.getAvailableDateString()
        datesDropDown?.onItemSelected = { [weak self] selectedItem, selectedIndex in
            self?.selectedDateLabel.text = selectedItem
            self?.selectedShowTimeLabel.isEnabled = true
            self?.selectedShowTimeLabel.text = "Select Show Time"
            self?.datesDropDownView.isHidden = true
            self?.viewModel.dateSelectionAction(at: selectedIndex)
            self?.showTimeDropDownView.isHidden = false
            self?.setUpShowTimeDropDown()
        }
        setupDatesTapGesture()
    }

    private func setUpShowTimeDropDown() {
        showTimeDropDownView.isHidden = true
        showTimeDropDownView.backgroundColor = .systemPink
        showTimeDropDown = Bundle.main.loadNibNamed("DropDownView",
                                                    owner: self,
                                                    options: nil)?.first as? DropDownView
        showTimeDropDown?.frame = showTimeDropDownView.bounds
        showTimeDropDownView.addSubview(showTimeDropDown!)
        showTimeDropDown?.items = viewModel.getAvailableShowTime()
        showTimeDropDown?.onItemSelected = { [weak self] selectedItem, selectedIndex in
            self?.selectedShowTimeLabel.text = selectedItem
            self?.showTimeDropDownView.isHidden = true
        }
        setupShowTimeTapGesture()
    }

    func setupTheatreTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(toggleTheatreDropDown))
        selectTheaterLabel.addGestureRecognizer(tapGesture)
    }

    func setupMovieTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(toggleMovieDropDown))
        selectMovieLabel.addGestureRecognizer(tapGesture)
    }
    
    func setupDatesTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(toggleDatesDropDown))
        selectedDateLabel.addGestureRecognizer(tapGesture)
    }

    func setupShowTimeTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(toggleShowTimeDropDown))
        selectedShowTimeLabel.addGestureRecognizer(tapGesture)
    }

    @objc func toggleTheatreDropDown() {
         theaterDropDownView.isHidden.toggle()
         theaterDropDown?.toggleDropdown()
    }

    @objc func toggleMovieDropDown() {
         moviesDropDownView.isHidden.toggle()
         movieDropDown?.toggleDropdown()
    }

    @objc func toggleDatesDropDown() {
         datesDropDownView.isHidden.toggle()
         datesDropDown?.toggleDropdown()
    }
    
    @objc func toggleShowTimeDropDown() {
         showTimeDropDownView.isHidden.toggle()
         showTimeDropDown?.toggleDropdown()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        viewModel.updateLocation(currentLatitude: latitude,
                                 currentLongitude: longitude)
        distanceLabel.text = viewModel.getLocationString()
    }

    // Handle errors with location services
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

