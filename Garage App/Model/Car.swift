//
//  Car.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import Foundation
import UIKit
import RealmSwift

final class Car: Object {
    @objc dynamic var make: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var image: NSData = NSData()
    
    init(make: String, model: String, image: UIImage) {
        super.init()
        self.make = make
        self.model = model
        let imageData = NSData(data: (image.pngData() ?? image.jpegData(compressionQuality: 0.9)) ?? Data())
        self.image = imageData
    }
    
    required override init() {
        super.init()
    }
    
}
