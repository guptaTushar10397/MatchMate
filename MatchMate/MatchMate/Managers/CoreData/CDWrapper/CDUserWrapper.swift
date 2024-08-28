//
//  CDUserWrapper.swift
//  MatchMate
//
//  Created by Tushar Gupta on 28/08/24.
//

import Foundation
import CoreData

final class CDUserWrapper {

    // Convert User to CDUser
    static func convertToCDUser(user: User, context: NSManagedObjectContext) -> CDUser {
        let cdUser = CDUser(context: context)
        cdUser.id = user.id
        cdUser.userAction = user.userAction?.rawValue
        
        if let name = user.name {
            cdUser.name = convertToCDName(name: name, context: context)
        }
        
        if let location = user.location {
            cdUser.location = convertToCDLocation(location: location, context: context)
        }

        if let picture = user.picture {
            cdUser.picture = convertToCDPicture(picture: picture, context: context)
        }

        if let backendID = user.backendID {
            cdUser.backendID = convertToCDBackendID(backendID: backendID, context: context)
        }

        return cdUser
    }

    // Convert CDUser to User
    static func convertToUser(cdUser: CDUser) -> User {
        var user = User()
        
        if let id = cdUser.id {
            user.id = id
        }
        
        if let userAction = cdUser.userAction {
            user.userAction = UserAction(rawValue: userAction)
        }
        
        if let cdName = cdUser.name {
            user.name = convertToName(cdName: cdName)
        }

        if let cdLocation = cdUser.location {
            user.location = convertToLocation(cdLocation: cdLocation)
        }

        if let cdPicture = cdUser.picture {
            user.picture = convertToPicture(cdPicture: cdPicture)
        }

        if let cdBackendID = cdUser.backendID {
            user.backendID = convertToBackendID(cdBackendID: cdBackendID)
        }

        return user
    }

    // Helper functions to convert between Name and CDName
    static func convertToCDName(name: Name, context: NSManagedObjectContext) -> CDName {
        let cdName = CDName(context: context)
        cdName.title = name.title
        cdName.first = name.first
        cdName.last = name.last
        return cdName
    }

    static func convertToName(cdName: CDName) -> Name {
        return Name(title: cdName.title, first: cdName.first, last: cdName.last)
    }
    
    // Helper functions to convert between Location and CDLocation
    static private func convertToCDLocation(location: Location, context: NSManagedObjectContext) -> CDLocation {
        let cdLocation = CDLocation(context: context)
        cdLocation.city = location.city
        cdLocation.country = location.country
        cdLocation.state = location.state
        
        if let street = location.street {
            cdLocation.street = convertToCDStreet(street: street, context: context)
        }
        return cdLocation
    }

    static private func convertToLocation(cdLocation: CDLocation) -> Location {
        var location = Location(city: cdLocation.city, state: cdLocation.state, country: cdLocation.country)
        
        if let street = cdLocation.street {
            location.street = convertToStreet(cdStreet: street)
        }
        
        return location
    }

    // Helper functions to convert between Street and CDStreet
    static private func convertToCDStreet(street: Street, context: NSManagedObjectContext) -> CDStreet {
        let cdStreet = CDStreet(context: context)
        cdStreet.name = street.name
        cdStreet.number = Int64(street.number ?? 0)
        return cdStreet
    }

    static private func convertToStreet(cdStreet: CDStreet) -> Street {
        return Street(number: Int(cdStreet.number), name: cdStreet.name)
    }
    
    // Helper functions to convert between Picture and CDPicture
    static private func convertToCDPicture(picture: Picture, context: NSManagedObjectContext) -> CDPicture {
        let cdPicture = CDPicture(context: context)
        cdPicture.large = picture.large
        cdPicture.medium = picture.medium
        cdPicture.thumbnail = picture.thumbnail
        return cdPicture
    }

    static private func convertToPicture(cdPicture: CDPicture) -> Picture {
        return Picture(large: cdPicture.large, medium: cdPicture.medium, thumbnail: cdPicture.thumbnail)
    }

    // Helper functions to convert between BackendID and CDBackendID
    static private func convertToCDBackendID(backendID: BackendID, context: NSManagedObjectContext) -> CDBackendID {
        let cdBackendID = CDBackendID(context: context)
        cdBackendID.name = backendID.name
        cdBackendID.value = backendID.value
        return cdBackendID
    }

    static private func convertToBackendID(cdBackendID: CDBackendID) -> BackendID {
        return BackendID(name: cdBackendID.name, value: cdBackendID.value)
    }
}
