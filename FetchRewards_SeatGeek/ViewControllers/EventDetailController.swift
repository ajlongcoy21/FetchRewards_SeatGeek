//
//  EventDetailController.swift
//  FetchRewards_SeatGeek
//
//  Created by Alan Longcoy on 3/6/21.
//

import Foundation
import UIKit

class EventDetailViewController: UIViewController
{
    // Connect controller to the view items
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueExtendedAddressLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    
    // event variable set through the segue
    var event: Event?

    // On view did load, set information based on event selected from tableview

    override func viewDidLoad()
    {
        let defaults = UserDefaults.standard
        let favorite = defaults.bool(forKey: "\(event!.id)")
        
        if favorite == true
        {
            favoriteButton.setImage( UIImage.init(named: "favorite"), for: .normal)
            
        }
        else
        {
            favoriteButton.setImage( UIImage.init(named: "NotFavorite"), for: .normal)
        }
        
        titleLabel.text = event?.title
        venueNameLabel.text = event?.venueName
        venueAddressLabel.text = event?.address
        venueExtendedAddressLabel.text = event?.extendedAddress
        
    }
    
    // Button action to toggle the persistance of favorite events 
    
    @IBAction func toggleFavorite(_ sender: Any)
    {
        let defaults = UserDefaults.standard
        let favorite = defaults.bool(forKey: "\(event!.id)")
        
        if favorite == true
        {
            favoriteButton.setImage( UIImage.init(named: "NotFavorite"), for: .normal)
            defaults.removeObject(forKey: "\(event!.id)")
            
        }
        else
        {
            favoriteButton.setImage( UIImage.init(named: "favorite"), for: .normal)
            defaults.set(true, forKey: "\(event!.id)")
        }
    }
    
    
    
}
