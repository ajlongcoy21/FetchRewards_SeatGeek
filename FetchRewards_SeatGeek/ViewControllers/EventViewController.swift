//
//  ViewController.swift
//  FetchRewards_SeatGeek
//
//  Created by Alan Longcoy on 3/5/21.
//

//  client ID: MjE1NzYxOTl8MTYxNTAxMjM4MC41NjIwNzA0
// secret key: 9ade62ac1868d8ff66cde15aa18f3f854061c7eb17fd70a3f41da0cb9b405e09

import UIKit

class EventViewController: UITableViewController, UISearchBarDelegate
{
    // Connect controller to the view items
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // define cell height
    
    private struct Constants
    {
        static let EventCellHeight: CGFloat = 200
    }
    
    // create a client to be able to make calls to the api
    
    var client = APIClient()
    
    // setup the datasource for the tableview
    
    lazy var dataSource: EventListDataSource =
    {
        var eventsDownloaded: [Event] = []
        
        client.getEvents()
        {
            myEvents, error in
            
            guard let myEvents = myEvents else
            {
                return
            }
            
            self.reloadData(events: myEvents.events)
            
        }
        
        return EventListDataSource(events: eventsDownloaded, tableView: self.tableView)
    }()
    
    // On view did load setup data and view display colors
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        self.view.backgroundColor = UIColor(hex: "#313D4E")
        
        searchBar.delegate = self
                
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // setup the cell height to fit the contents of the cell
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Constants.EventCellHeight
    }
    
    override func willMove(toParent parent: UIViewController?)
    {
        //self.navigationController?.navigationBar.isHidden = true
    }
    
    // When returning from the detail view, need to reload data incase an event was selected as a favorite
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // setup the segue - get event selected and pass to next controller
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        let eventDetailController = segue.destination as! EventDetailViewController
        eventDetailController.event = dataSource.getEvent(at: tableView.indexPathForSelectedRow!)
        
    }
    
    // make calls to the api as the search bar is updated with each button press
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        client.getSearch(searchTerm: searchText)
        {
            myEvents, error in
            
            guard let myEvents = myEvents else
            {
                return
            }
            
            self.reloadData(events: myEvents.events)
            
        }
    }

    // function to reload the data for the user
    
    func reloadData(events: [Event])
    {
        dataSource.update(with: events)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

}

// function to get UIColor from hex values

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

