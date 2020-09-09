//
//  User.swift
//  UserDemoApp
//
//  Created by SaurabhMishra on 08/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: - User Model


class User:Object, Codable {
    @objc dynamic var id:String?
    @objc dynamic var type: String?
    @objc dynamic var date:String?
    @objc dynamic var data: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}


