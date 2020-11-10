//
//  PeopleInfoAllModels.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import RealmSwift

class Picture: Object {

    @objc dynamic var large: String!
    @objc dynamic var medium: String!
    @objc dynamic var thumbnail: String!
}

class Name: Object {

    @objc dynamic var first: String!
    @objc dynamic var last: String!
    @objc dynamic var title: String!
    
    var fullName: String {
        return title + " " + first + " " + last
    }
}

class Login: Object {

    @objc dynamic var md5: String!
    @objc dynamic var password: String!
    @objc dynamic var salt: String!
    @objc dynamic var sha1: String!
    @objc dynamic var sha256: String!
    @objc dynamic var username: String!
    @objc dynamic var uuid: String!
    
    var security: String {
        return "UUID: " + uuid + "\n\n" + "Username: " + username + "\n" + "Password: " + password + "\n\n" + "Salt: " + salt
    }
}

class Location: Object {

    @objc dynamic var city: String!
    @objc dynamic var coordinates: Coordinate!
    @objc dynamic var country: String!
    @objc dynamic var postcode: String?
    @objc dynamic var state: String!
    @objc dynamic var street: Street!
    @objc dynamic var timezone: Timezone!
    
    /// not fixed data type from JSON, that's why ignore
    override static func ignoredProperties() -> [String] {
        return ["postcode"]
    }
    
    var address: String {
        return "\(street.number) " + street.name + ", " + city + ", " + state + ", " + country
    }
}

class Timezone: Object {

    @objc dynamic var descriptionField: String!
    @objc dynamic var offset: String!
}

class Street: Object {

    @objc dynamic var name: String!
    @objc dynamic var number: Int = 0
}

class Coordinate: Object {

    @objc dynamic var latitude: String!
    @objc dynamic var longitude: String!
}

class Id: Object {

    @objc dynamic var name: String!
    @objc dynamic var value: String!
}

class Dob: Object {

    @objc dynamic var age: Int = 0
    @objc dynamic var date: String!
    
    var dateAge: String {
        return "Age: \(age)" + "\n\n" + "DOB: " + date
    }
}
