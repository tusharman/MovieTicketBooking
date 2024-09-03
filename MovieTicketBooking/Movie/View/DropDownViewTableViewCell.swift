//
//  DropDownViewTableViewCell.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import UIKit

class DropDownViewTableViewCell: UITableViewCell {

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var extraInfoLabel: UILabel!

    func configureCell(description: String?, extraInfo: String? = nil) {
        descriptionLabel.text = description
        extraInfoLabel.text = extraInfo
    }
}
