//
//  Runner.swift
//  JoggingManager
//
//  Created by Keelan Savat on 06/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import Foundation

struct Runner: Codable {
    var startNumber: Int
    var name: String
    var gender: String
    var finish: String?
    var raceId: Int
    var ranking: Int?
    
    enum CodingKeys: String, CodingKey {
        case startNumber
        case name
        case gender
        case finish
        case raceId = "race_id"
        case ranking
    }
}
