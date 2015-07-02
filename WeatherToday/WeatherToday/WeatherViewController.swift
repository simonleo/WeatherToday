//
//  WeatherViewController.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit
import WeatherTodayManageKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var lowTmpLabel: UILabel!
    @IBOutlet weak var highTmpLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var cityInfo: CityInfo!
    var weatherManager: WeatherManager!
    var weatherEvent: WeatherEvent! {
        didSet {
            dispatch_async(dispatch_get_main_queue()) {
                if let event = self.weatherEvent {
                    self.cityLabel.text = event.city
                    self.weatherLabel.text = event.weather
                    self.lowTmpLabel.text = "最低温度：\(event.l_tmp)"
                    self.highTmpLabel.text = "最高温度：\(event.h_tmp)"
                    self.dateLabel.text = event.date
                } else {
                    println("weatherEvent is nil!")
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(cityInfo != nil, "city not set")
        weatherManager = WeatherManager()
        weatherManager.getEvents(cityInfo!, callback: {
            weatherEvent in
            self.weatherEvent = weatherEvent
        })
        

    }
    
    

}