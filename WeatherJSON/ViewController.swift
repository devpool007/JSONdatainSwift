//
//  ViewController.swift
//  WeatherJSON
//
//  Created by Devansh Sharma on 12/05/17.
//  Copyright © 2017 Devansh Sharma. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var searchbar: UISearchBar!
    
    var forecastData = [Weather]()
    
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        searchbar.delegate = self
        updateWeatherForLocation(location: "Chennai")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            updateWeatherForLocation(location: locationString)
        }
    }
    
    
    func updateWeatherForLocation (location:String){
        CLGeocoder().geocodeAddressString(location){ (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location{
                    Weather.forecast(withLocation: location.coordinate, completion: { (results:[Weather]?) in
                        
                        if let weatherData = results {
                            self.forecastData = weatherData
                            
                            DispatchQueue.main.async {
                                self.table.reloadData()
                                
                            }
                        }
                    })
                }
            }
        
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastData.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
    
        return dateFormatter.string(from: date!)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let weatherObject = forecastData[indexPath.section]
        cell.textLabel?.text = weatherObject.summary
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 14)
        cell.detailTextLabel?.text = "\(Int(weatherObject.temperature))" + " ºF"
        cell.detailTextLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
        cell.imageView?.image = UIImage(named: weatherObject.icon)
        return cell
    }

}


    
    
    
    
    
    
    
    

