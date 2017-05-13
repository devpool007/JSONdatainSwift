//
//  Weather.swift
//  WeatherJSON
//
//  Created by Devansh Sharma on 13/05/17.
//  Copyright © 2017 Devansh Sharma. All rights reserved.
//

import Foundation

struct Weather {
    
    let summary:String
    let icon:String
    let temperature:Double
    


    enum SerializationError:Error {

        case missing(String)
        case invalid(String,Any)

}


    init(json:[String:Any]) throws {
    
        guard let summary = json["summary"] as? String else  {
     
            throw SerializationError.missing("Summary is missing")
        
    }
    
        guard let icon = json["icon"] as? String else {
    
            throw SerializationError.missing("Icon is missing")
    }
    
        guard let temperature = json["temperatureMax"] as? Double else {
        
            throw SerializationError.missing("Temperature not available")
    }
    
    self.summary = summary
    self.icon = icon
    self.temperature = temperature
    
    
    }

    static let basepath = "https://api.darksky.net/forecast/4952b47c472360fa6346170ea291d7fd/"
    
    
    static func forecast(withLocation location:String, completion: @escaping ([Weather]) ->() ) {
        
        
        let url = basepath + location
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather] = []
            
            if let data = data {
            
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                     
                        if let dailyForecasts = json["daily"] as? [String:Any]{
                         
                            if let dailyData = dailyForecasts["data"] as? [[String:Any]]{
                                
                                for dataPoint in dailyData{
                                    if let weatherObject = try? Weather(json:dataPoint){
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                    }
                    
                }catch {
                print(error.localizedDescription)
            }
            
            
            completion(forecastArray)
            
            
            }
            
        
    }
        task.resume()

    
    
    
    }
}
