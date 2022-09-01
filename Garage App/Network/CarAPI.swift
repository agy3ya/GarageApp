//
//  CarAPI.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import Foundation
import Moya

enum CarsAPI {
    case getCarsMake
    case getCarsModel(makeID: Int)
}

extension CarsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://vpic.nhtsa.dot.gov/")!
    }
    
    var path: String {
        switch self {
        case .getCarsMake:
            return "api/vehicles/getallmakes"
        case .getCarsModel(makeID: let makeID):
            return "api/vehicles/GetModelsForMakeId/\(makeID)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCarsMake:
            return .requestParameters(parameters: ["format" : "json"], encoding: URLEncoding.queryString)
        case .getCarsModel(makeID: _):
            return .requestParameters(parameters: ["format" : "json"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
}
