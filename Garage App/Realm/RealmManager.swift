//
//  RealmManager.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import Foundation


import UIKit
import RealmSwift
import Realm
class RealmManager {
    static let shared = RealmManager()
    let realm = try! Realm()
    open func deleteDatabase() {
        do {
            try? self.realm.write({
                self.realm.deleteAll()
            })
        }
    }
    
    open func saveObject(objs: Object) {
        do {
            try? self.realm.write({
                self.realm.add(objs)
            })
        }
    }
    
    open func saveObjectWithUpdate(obj : Object) {
        do {
            try? self.realm.write({
                RealmManager.shared.realm.add(obj, update: .modified)
            })
        }
    }
    
    open func deleteObject(obj : Object) {
        do {
            try? self.realm.write({
                self.realm.delete(obj)
            })
        }
    }
    
    open func fetchDataForObject<T: Any>(objectType: T.Type ) -> [T] {
        let type = objectType as! Object.Type
        return realm.objects(type).toArray(ofType: T.self)
    }
}
