//
//  CarModelData.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import Foundation


struct CarModeldata: Codable {
    let count: Int
    let message, searchCriteria: String
    let results: [CarModel]

    enum CodingKeys: String, CodingKey {
        case count = "Count"
        case message = "Message"
        case searchCriteria = "SearchCriteria"
        case results = "Results"
    }
}


struct CarModel: Codable {
    let makeID: Int
    let makeName: String
    let modelID: Int
    let modelName: String

    enum CodingKeys: String, CodingKey {
        case makeID = "Make_ID"
        case makeName = "Make_Name"
        case modelID = "Model_ID"
        case modelName = "Model_Name"
    }
}
