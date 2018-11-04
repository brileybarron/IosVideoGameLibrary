//
//  ESRBRating.swift
//  IosVideoGameLibrary
//
//  Created by Briley Barron on 10/29/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import Foundation

enum ESRBRating: String {
    case EC = "EC"        //Early Childhood
    case E = "E"          //Everyone
    case E10Up = "E10+"   //Everyone 10 and older
    case T = "T"          //Teens or older than 13
    case M = "M"          //Mature and any one over 17
    case AO = "AO"        //Adults only
    case RP = "RP"        //rating pending
    case NR = "NR"        //Not Rated this will only occur if a value is not given
}
