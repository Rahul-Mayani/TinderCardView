//
//  AppDelegate.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var realm = try? Realm()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // realm setup
        realmMigration()
        do {
            realm = try? Realm()
        }
        /*
        /// setup initial view
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintAdjustmentMode = .normal
        window?.rootViewController = PeopleVC()
        window?.makeKeyAndVisible()
        */
        return true
    }
}

// MARK: - Realm -
extension AppDelegate {
    
    private func realmMigration() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
         
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if oldSchemaVersion < 1 {
                    // the magic happens here: `id` is the property you specified
                    // as your primary key on your Model
                }
            })
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
}
