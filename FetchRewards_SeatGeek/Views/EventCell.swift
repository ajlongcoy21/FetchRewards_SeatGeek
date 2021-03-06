//
//  EventCell.swift
//  FetchRewards_SeatGeek
//
//  Created by Alan Longcoy on 3/5/21.
//

import Foundation
import UIKit

class EventCell: UITableViewCell
{
    // connect view items to eventCell class
    
    static let reuseIdentifier = "EventCell"
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with viewModel: EventCellModel, row: Int)
    {
        // Look to see if the event is a favorite event
        let defaults = UserDefaults.standard
        let favorite = defaults.bool(forKey: "\(viewModel.id)")
        
        // if a favorite event is shown, indicate that to the user
        if favorite == true
        {
            favoriteImage.isHidden = false
        }
        else
        {
            favoriteImage.isHidden = true
        }
        
        // Show event information
        
        eventType.text = viewModel.type
        eventTitle.text = viewModel.title
        eventLocation.text = viewModel.location
        
        // create dateFormatter with UTC time format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: viewModel.time)// create   date from string

        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: date!)
        eventTime.text = timeStamp
    }
    
}
