//
//  ViewController.swift
//  WeatherJSON
//
//  Created by Devansh Sharma on 12/05/17.
//  Copyright © 2017 Devansh Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Weather.forecast(withLocation: "37.8267,-122.4233") { (results:[Weather]) in
            
            for result in results{
                print("\(result)\n\n")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

