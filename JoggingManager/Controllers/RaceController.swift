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
            if error != nil {
                completion(nil)
                return
            }
            
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
    
    func submitRunners(runners: [Runner], completion: @escaping ([Runner]?) -> Void) {
        let runnersUrl = baseUrl.appendingPathComponent("runners")
        
        var request = URLRequest(url: runnersUrl)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data: [Runner] = runners
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil)
                return
            } else {
                let jsonDecoder = JSONDecoder()
                if let data = data,
                    let runnerList = try? jsonDecoder.decode(Array<Runner>.self, from: data) {
                    completion(runnerList)
                } else {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
