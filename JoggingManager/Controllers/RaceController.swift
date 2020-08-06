//
//  File.swift
//  JoggingManager
//
//  Created by Keelan Savat on 06/08/2020.
//  Copyright © 2020 Keelan Savat. All rights reserved.
//

import Foundation

class RaceController {
    static let shared = RaceController()
    
    func fetchRaces(completion: @escaping ([Race]?) -> Void) {
        
    }
    
    func fetchRunners(raceId: Int, completion: @escaping ([Runner]?) -> Void) {
        
    }
    
    func submitRunners(raceId: Int, runners: [Runner], completion: @escaping (Int?) -> Void) {
        
    }
}
