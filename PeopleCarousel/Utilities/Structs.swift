//
//  Structs.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

public struct RRAPIEndPoint {
    
    static let endPointURL = Environment.production.rawValue
    
    private enum Environment: String {
        case develop = "local host"
        case staging = "stage"
        case production = "https://randomuser.me/api/"
    }
    
    struct Name {
        static let listOfPeople = endPointURL + "?results=50"
    }
}

public struct RRViewController {
    
    struct Name {
        static let peopleVC = "People"
    }
}
