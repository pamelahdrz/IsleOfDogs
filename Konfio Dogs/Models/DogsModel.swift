//
//  Dogs.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 16/11/23.
//

import Foundation

struct DogsModel: Decodable {
    var name: String?
    var description: String?
    var age: Int?
    var image: String?
    
    init(entity: DogsEntity) {
        self.name = entity.name
        self.description = entity.dogDescription
        self.age = Int(entity.age)
        self.image = entity.image
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "dogName"
        case description = "description"
        case age
        case image = "image"
    }
}

extension DogsModel {
    var imageURL: URL? {
        guard let url = image else { return nil }
        return URL(string: url)
    }
}
