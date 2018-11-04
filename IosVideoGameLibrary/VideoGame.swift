//
//  VideoGame.swift
//  IosVideoGameLibrary
//
//  Created by Briley Barron on 10/29/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import Foundation

class VideoGame {
    //properties: title, genre, rating, description, availability status, and due date
    var title: String
    var genre: Genre
    var ESRB: ESRBRating
    var description: String
    var avaliability: Availability
    var dueDate: Date?
    
    init(title: String, genre: Genre, ESRB: ESRBRating, description: String) {
        self.title = title
        self.genre = genre
        self.ESRB = ESRB
        self.description = description
        self.avaliability = .checkedIn
        
    }
}
