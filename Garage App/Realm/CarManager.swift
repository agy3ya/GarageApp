//
//  CarManager.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import Foundation
import RealmSwift
class CarManager {
    static var shared = CarManager()
    
    func saveCarToDB(car: Car) {
        try? RealmManager.shared.realm.write {
            UserLoginManager.shared.currentUser?.carList.append(car)
        }
    }
    
    func deleteCarFromDB(car: Car, handler: (() -> ())) {
        if let car = RealmManager.shared.realm.objects(Car.self).filter({ $0.make == car.make && $0.model == car.model }).first {
            RealmManager.shared.deleteObject(obj: car)
        }
        handler()
    }
    
    func getCar() -> List<Car> {
        let car = UserLoginManager.shared.currentUser?.carList ?? List<Car>()
        return car
    }
}
