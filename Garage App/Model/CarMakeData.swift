//
//  CarMakeData.swift
//  Garage App
//
//  Created by Ankit Singh on 02/09/22.
//

import Foundation

struct CarMakeData: Codable {
    let count: Int
    let message: String
    let results: [CarMake]

    enum CodingKeys: String, CodingKey {
        case count = "Count"
        case message = "Message"
        case results = "Results"
    }
}

struct CarMake: Codable {
    let makeID: Int
    let makeName: String

    enum CodingKeys: String, CodingKey {
        case makeID = "Make_ID"
        case makeName = "Make_Name"
    }
}
