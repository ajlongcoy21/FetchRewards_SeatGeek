//
//  EventListDataSource.swift
//  FetchRewards_SeatGeek
//
//  Created by Alan Longcoy on 3/5/21.
//

import Foundation
import UIKit

// Create datasource for eventlist table view

class EventListDataSource: NSObject, UITableViewDataSource
{
    
    private var events: [Event]
    
    let tableView: UITableView
    
    init(events: [Event], tableView: UITableView)
    {
        self.events = events
        self.tableView = tableView
        
        super.init()
    }
    
    func update(with events: [Event])
    {
        self.events = events
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let eventCell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier, for: indexPath) as! EventCell
        
        let event = events[indexPath.row]
        
        let viewModel = EventCellModel(id: event.id, type: event.type, title: event.title, location: event.location, time: event.time)
        
        eventCell.configure(with: viewModel, row: indexPath.row)
        
        eventCell.layer.borderWidth = 2.0
        eventCell.layer.borderColor = UIColor.gray.cgColor
        
        return eventCell
    }
    
    func getEvent(at indexPath: IndexPath) -> Event
    {
        return events[indexPath.row]
    }
}
