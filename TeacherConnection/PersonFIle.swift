//
//  PersonFIle.swift
//  TeacherConnection
//
//  Created by Mark Wilson on 1/8/21.
//

import Foundation

struct Person: Codable {
    var name: String
    var isTeacher: Bool
    
    
    static var archiveURL: URL {
           let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
           let archiveURL = documentsURL.appendingPathComponent("person").appendingPathExtension("plist")
           return archiveURL

}
    static func saveToFile(person: [Person]) {
        let encoder = PropertyListEncoder()
        do {
            let encodedPerson = try encoder.encode(person)
            try encodedPerson.write(to: Person.archiveURL)
        } catch {
            print("Error encoding person: \(error)")
        }
    }
    static func loadFromFile() -> [Person]? {
        guard let personData = try? Data(contentsOf: Person.archiveURL) else {
            return nil
        }
        do {
            let decoder = PropertyListDecoder()
            let decodedPerson = try decoder.decode([Person].self, from: personData)
            return decodedPerson
        } catch {
            print("Error decoding person: \(error)")
            return nil
        }
        
    }

}
