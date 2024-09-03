//
//  DropDownView.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import UIKit

class DropDownView: UIView {
    // @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var items: [(String?, String?)]? = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var movies: [MovieDetails]? {
        didSet {
            tableView.reloadData()
        }
    }

    var onItemSelected: ((String?, Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.isHidden = true
        tableView.register(UINib(nibName: "DropDownViewTableViewCell",
                                 bundle: Bundle.main),
                           forCellReuseIdentifier: "DropDownCell")
    }
    
    @objc func toggleDropdown() {
        tableView.isHidden.toggle()
    }
}

extension DropDownView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath) as! DropDownViewTableViewCell
        let info = items?[indexPath.row]
        cell.configureCell(description: info?.0, extraInfo: info?.1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items?[indexPath.row]
        onItemSelected?(selectedItem?.0, indexPath.row)
        // titleLabel.text = selectedItem
        tableView.isHidden = true
    }
}
