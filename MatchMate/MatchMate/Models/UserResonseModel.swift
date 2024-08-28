//
//  UserResonseModel.swift
//  MatchMate
//
//  Created by Tushar Gupta on 27/08/24.
//

import Foundation

enum UserAction: String {
    case accepted = "accepted"
    case rejected = "rejected"
    
    var displayValue: String {
        switch self {
        case .accepted:
            "Accepted"
        case .rejected:
            "Declined"
        }
    }
}

// MARK: - UserResponse Model
struct UserResponse: Codable {
    var results: [User]?
}

// MARK: - User Model
struct User: Codable, Identifiable {
    var id: String = UUID().uuidString
    var userAction: UserAction? = nil
    var name: Name?
    var location: Location?
    var picture: Picture?
    var backendID: BackendID?
    
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
    
    init(id: String = UUID().uuidString, userAction: UserAction? = nil, name: Name? = nil, location: Location? = nil, picture: Picture? = nil, backendID: BackendID? = nil) {
        self.id = id
        self.userAction = userAction
        self.name = name
        self.location = location
        self.picture = picture
        self.backendID = backendID
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
    var number: Int?
    var name: String?
}

// MARK: - ID Model
struct BackendID: Codable {
    var name: String?
    var value: String?
}

// MARK: - Mock User
extension User {
    
    static let mockUser = User(
        name: Name(
            title: "Mrs.",
            first: "María Cristina",
            last: "Ceja"
        ),
        location: Location(
            street: Street(
                number: 123,
                name: "Main St"
            ),
            city: "Anytown",
            state: "Anystate",
            country: "Anycountry"
        ),
        picture: Picture(
            large: "https://randomuser.me/api/portraits/women/89.jpg",
            medium: "https://randomuser.me/api/portraits/med/women/89.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/women/89.jpg"
        ),
        backendID: BackendID(
            name: "user",
            value: "12345"
        )
    )
    
    static let mockUserAccepted = User(
        userAction: .accepted,
        name: Name(
            title: "Mrs.",
            first: "María Cristina",
            last: "Ceja"
        ),
        location: Location(
            street: Street(
                number: 123,
                name: "Main St"
            ),
            city: "Anytown",
            state: "Anystate",
            country: "Anycountry"
        ),
        picture: Picture(
            large: "https://randomuser.me/api/portraits/women/89.jpg",
            medium: "https://randomuser.me/api/portraits/med/women/89.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/women/89.jpg"
        ),
        backendID: BackendID(
            name: "user",
            value: "12345"
        )
    )
    
    static let mockUserRejected = User(
        userAction: .rejected,
        name: Name(
            title: "Mrs.",
            first: "María Cristina",
            last: "Ceja"
        ),
        location: Location(
            street: Street(
                number: 123,
                name: "Main St"
            ),
            city: "Anytown",
            state: "Anystate",
            country: "Anycountry"
        ),
        picture: Picture(
            large: "https://randomuser.me/api/portraits/women/89.jpg",
            medium: "https://randomuser.me/api/portraits/med/women/89.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/women/89.jpg"
        ),
        backendID: BackendID(
            name: "user",
            value: "12345"
        )
    )
}

