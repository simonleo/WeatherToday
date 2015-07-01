//
//  WeatherViewController.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    var cityInfo: CityInfo!
    var weatherManager: WeatherManager!
    var weatherEvents: WeatherEvent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(cityInfo != nil, "city not set")
        weatherManager = WeatherManager()
        weatherManager.getEvents(cityInfo!, callback: {
            weatherEvents in
            self.weatherEvents = weatherEvents
        })
        
        button.addTarget(self,action:Selector("tapped"),forControlEvents:UIControlEvents.TouchUpInside)
    }
    
    
    func tapped(){
        println("tapped")
    }
}