//
//  UserResonseModel.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

// MARK: - UserResponse Model
struct UserResponse: Codable {
    var results: [User]?
}

// MARK: - User Model
struct User: Codable, Identifiable {
    var id: String = UUID().uuidString
    let name: Name?
    let location: Location?
    let picture: Picture?
    let backendID: BackendID?
    
    enum CodingKeys: String, CodingKey {
        case backendID = "id"
        case name
        case location
        case picture
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backendID = try container.decodeIfPresent(BackendID.self, forKey: .backendID)
        if let backendID = self.backendID?.value  {
            self.id = backendID
        }
        self.name = try container.decodeIfPresent(Name.self, forKey: .name)
        self.location = try container.decodeIfPresent(Location.self, forKey: .location)
        self.picture = try container.decodeIfPresent(Picture.self, forKey: .picture)
    }
}


// MARK: - Name Model
struct Name: Codable {
    var title: String?
    var first: String?
    var last: String?
    
    var fullName: String {
        (first ?? "") + " " + (last ?? "")
    }
}

// MARK: - Location Model
struct Location: Codable {
    var street: Street?
    var city: String?
    var state: String?
    var country: String?
    
    var address: String {
        var fullAddress = ""
        
        if let number = street?.number {
            fullAddress = "\(number)" + ", "
        }
        
        if let name = street?.name {
            fullAddress += name + ", "
        }
        
        if let city = city {
            fullAddress += city + ", "
        }
        
        if let state = state {
            fullAddress += state + ", "
        }
        
        if let country = country {
            fullAddress += country
        }
        
        return fullAddress
    }
}

// MARK: - Picture Model
struct Picture: Codable {
    var large: String?
    var medium: String?
    var thumbnail: String?
}

// MARK: - Street Model
struct Street: Codable {
    let number: Int?
    let name: String?
}

// MARK: - ID Model
struct BackendID: Codable {
    let name: String?
    let value: String?
}

