//
//  CarRestManager.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import UIKit
import Moya
class CarRestManager: NSObject {
    private var provider = MoyaProvider<CarsAPI>()
    static var shared = CarRestManager()
    
    func getCarsMake(handler: ((Result<CarMakeData,Error>)->())?) {
        self.provider.request(.getCarsMake) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(CarMakeData.self, from: response.data)
                    handler?(.success(decodedData))
                } catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getCarsModel(makeID: Int, handler: ((Result<CarModeldata,Error>)->())?) {
        self.provider.request(.getCarsModel(makeID: makeID)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(CarModeldata.self, from: response.data)
                    handler?(.success(decodedData))
                } catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
}
