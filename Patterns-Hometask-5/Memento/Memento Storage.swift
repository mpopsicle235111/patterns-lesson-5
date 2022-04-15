//
//  Memento Storage.swift
//  Patterns-Hometask-5
//
//  Created by Anton Lebedev on 15.04.2022.
//

import UIKit


/// This is our container of variables, that we are going to store localy
struct Record: Codable {
    let name: String
    let number: Int
}

/// The business logic of this class is the local storage of Record container
final class RecordsCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "records"
    
    //[Record] is an array of Record models/containers
    func save(records: [Record]) {
        do {
            let data = try self.encoder.encode(records)
            //We can not store a Record container directly to UserDefaults
            //But we can encode it into binary via encoder/decoder
            //And as a binary we sure can store a container
            //in UserDefaults with a key
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveRecords() -> [Record] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            //The we can retrieve binary and decode it back to containers/models array
            return try self.decoder.decode([Record].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
