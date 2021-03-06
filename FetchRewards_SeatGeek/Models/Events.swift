//
//  Events.swift
//  FetchRewards_SeatGeek
//
//  Created by Alan Longcoy on 3/6/21.
//

import Foundation

// create model for events. Takes a JSON structure in an intializer to extract data from api response
class Events
{
    var events: [Event]
    
    init(allEvents: [Event])
    {
        self.events = allEvents
    }
    
}

extension Events
{
    convenience init?(json: [[String:Any]])
    {
        struct Key
        {
            static let id = "id"
            static let title = "title"
            static let time = "datetime_local"
            static let type = "type"
            static let venue = "venue"
            static let displaylocation = "display_location"
            static let venueName = "name"
            static let address = "address"
            static let extendedAddress = "extended_address"
 
        }
        
        var events: [Event] = []
        
        for eachEvent in json
        {
            guard let id = eachEvent[Key.id] as? Int else
            {
                return nil
            }
            
            guard let title = eachEvent[Key.title] as? String else
            {
                return nil
            }
            
            guard let time = eachEvent[Key.time] as? String else
            {
                return nil
            }
            
            guard let type = eachEvent[Key.type] as? String else
            {
                return nil
            }
            
            guard let venue = eachEvent[Key.venue] as? [String:Any] else
            {
                return nil
            }
            
            guard let location = venue[Key.displaylocation] as? String else
            {
                return nil
            }
            
            guard let name = venue[Key.venueName] as? String else
            {
                return nil
            }
            
            guard let address = venue[Key.address] as? String else
            {
                return nil
            }
            
            guard let extendedAddress = venue[Key.extendedAddress] as? String else
            {
                return nil
            }
            
            
            
            events.append(Event(id: id, type: type, title: title, location: location, time: time, venueName: name, address: address, extendedAddress: extendedAddress))
        }
        
        self.init(allEvents: events)
        
        
        
    }
}
