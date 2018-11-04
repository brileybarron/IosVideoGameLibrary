//
//  LibraryCell.swift
//  IosVideoGameLibrary
//
//  Created by Briley Barron on 11/1/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var availabilityView: UIView!
    var game = VideoGame(title: "a", genre: .shooter, ESRB: .NR, description: "b")
    
    func setup() {
        titleLabel.text = game.title
        genreLabel.text = game.genre.rawValue
        ratingLabel.text = game.ESRB.rawValue
        
        
        switch game.avaliability {
        case .checkedIn:
            //hide the due date
            dateLabel.isHidden = true
            //change the background color to ensure the user knows the game is in
            availabilityView.backgroundColor = .green
        case .checkedOut(let date):
            //shows the due date
            dateLabel.isHidden = true
            //changes the color to red
            availabilityView.backgroundColor = .red
            //sets the due date to a string
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateLabel.text = dateFormatter.string(from: date)
        }
    }
}
