//
//  PeopleModel.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import RealmSwift

class PeopleModel: Object {

    @objc dynamic var cell: String!
    @objc dynamic var dob: Dob!
    @objc dynamic var email: String!
    @objc dynamic var gender: String!
    @objc dynamic var id: Id!
    @objc dynamic var location: Location!
    @objc dynamic var login: Login!
    @objc dynamic var name: Name!
    @objc dynamic var nat: String!
    @objc dynamic var phone: String!
    @objc dynamic var picture: Picture!
    @objc dynamic var registered: Dob!
    
    @objc dynamic var isFavourite: Bool = false
    
    override class func primaryKey() -> String? {
        return "email"
    }
    
    /// ID values are miss match from JSON (received null value)
    var userBasicInfo: String {
        return "Email: " + email + "\n\n" + "Gender: " + gender + "\n\n" + "Nat: " + nat + "\n\n\n" //+ "ID: \(String(describing: id.name).removedOptional()) - \(String(describing: id.value).removedOptional())"
    }
    
    var userPhoneInfo: String {
        return "Phone: " + phone + "\n\n" + "Cell: " + cell
    }
}

extension PeopleModel {
    // save data into local DB
    class func create(from jsonResponse: [[String: Any]]) throws {
        do {
            // Delete all objects from the realm
            /*try appDelegate.realm.write {
                appDelegate.realm.deleteAll()
            }*/
            
            // Add new objects list in the realm
            appDelegate.realm!.beginWrite()
            for json in jsonResponse {
                appDelegate.realm!.create(PeopleModel.self, value: json, update: .modified)
            }
            try appDelegate.realm!.commitWrite()
        } catch { throw error }
    }
    
    /// update favourite people
    class func updateFavourite(_ people: PeopleModel) {
        try! appDelegate.realm!.write {
            people.isFavourite.toggle()
            appDelegate.realm!.add(people, update: .modified)
        }
    }
}
