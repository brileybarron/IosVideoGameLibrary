//
//  Library.swift
//  IosVideoGameLibrary
//
//  Created by Briley Barron on 10/29/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import Foundation

class Library {
    //Singleton
    static let sharedInstance = Library()
    
    var games = [VideoGame]()
}
