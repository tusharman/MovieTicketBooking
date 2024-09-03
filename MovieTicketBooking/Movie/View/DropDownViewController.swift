//
//  DropDownViewController.swift
//  MovieTicketBooking
//
//  Created by Tushar Mandhare on 31/08/24.
//

import UIKit

class DropDownViewController: UIViewController {

    @IBOutlet weak var dropdownContainerView: UIView!

       override func viewDidLoad() {
           super.viewDidLoad()
           setupDropdown()
       }

       private func setupDropdown() {
           self.view.backgroundColor = .red
           let dropdownView = Bundle.main.loadNibNamed("DropDownView",
                                                       owner: self,
                                                       options: nil)?.first as! DropDownView
           dropdownView.frame = dropdownContainerView.bounds
           dropdownContainerView.addSubview(dropdownView)
           let tapGesture = UITapGestureRecognizer(target: dropdownView, action: #selector(DropDownView.toggleDropdown))
           dropdownView.addGestureRecognizer(tapGesture)
       }
}
