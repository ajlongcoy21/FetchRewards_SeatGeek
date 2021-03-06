//
//  Event.swift
//  FetchRewards_SeatGeek
//
//  Created by Alan Longcoy on 3/5/21.
//

import Foundation

// create event model to hold information

class Event
{
    var id: Int
    var type: String
    var title: String
    var location: String
    var time: String
    
    var venueName: String
    var address: String
    var extendedAddress: String
    
    init(id: Int, type: String, title: String, location: String, time: String, venueName: String, address: String, extendedAddress: String)
    {
        self.id = id
        self.type = type
        self.title = title
        self.location = location
        self.time = time
        
        self.venueName = venueName
        self.address = address
        self.extendedAddress = extendedAddress
        
    }
    
}
