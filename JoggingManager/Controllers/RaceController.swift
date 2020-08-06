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

    let baseUrl = URL(string: "https://jogging.tools/")!
    
    func fetchRaces(completion: @escaping ([Race]?) -> Void) {
        let racesUrl = baseUrl.appendingPathComponent("races")
        
        let task = URLSession.shared.dataTask(with: racesUrl) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let races = try? jsonDecoder.decode(Array<Race>.self, from: data) {
                completion(races)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchRunners(_ raceId: Int, completion: @escaping ([Runner]?) -> Void) {
        let runnersUrl = baseUrl.appendingPathComponent("races").appendingPathComponent(String(raceId))
        
        let task = URLSession.shared.dataTask(with: runnersUrl) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let runners = try? jsonDecoder.decode(Array<Runner>.self, from: data) {
                completion(runners)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func submitRunners(raceId: Int, runners: [Runner], completion: @escaping (Int?) -> Void) {
        
    }
}
