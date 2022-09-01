//
//  User.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import Foundation
import RealmSwift

final class User: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    dynamic var carList = List<Car>()
    init(username: String, password: String) {
        super.init()
        self.username = username
        self.password = password
    }
    
    required override init() {
        super.init()
    }
        
    override public class func primaryKey() -> String {
        return "username"
    }
}

