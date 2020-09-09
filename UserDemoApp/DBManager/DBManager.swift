//
//  DBManager.swift
//  UserDemoApp
//
//  Created by SaurabhMishra on 09/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
     
    let realm = try! Realm()
     
    /**
     Delete local database
     */
    func deleteDatabase() {
        try! realm.write({
            realm.deleteAll()
        })
    }
     
    /**
     Save array of objects to database
     */
    func saveObjects(objs: [Object]) {
        try! realm.write({
            // If update = true, objects that are already in the Realm will be
            // updated instead of added a new.
            realm.add(objs, update: .modified)
        })
    }
     
    /**
     Returs an array as Results<Object>?
     */
    func getObjects(type: Object.Type) -> Results<Object>? {
        return realm.objects(type)
    }
}
