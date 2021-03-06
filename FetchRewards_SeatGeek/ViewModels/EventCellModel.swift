//
//  EventCellModel.swift
//  FetchRewards_SeatGeek
//
//  Created by Alan Longcoy on 3/5/21.
//

import Foundation
import UIKit

// Create a model for the event cell

struct EventCellModel
{
    var id: Int
    var type: String
    var title: String
    var location: String
    var time: String
    
    init(id: Int, type: String, title: String, location: String, time: String)
    {
        self.id = id
        self.type = type
        self.title = title
        self.location = location
        self.time = time
    }
}
