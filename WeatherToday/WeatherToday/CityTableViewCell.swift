//
//  CityTableViewCell.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit
import WeatherTodayManageKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!

    
    
    var cityWeatherEvent: WeatherEvent? {
        didSet {
            if let weatherEvent = cityWeatherEvent {
                cityNameLabel.text = weatherEvent.cityName
                cityNameLabel.font = UIFont.systemFontOfSize(15)
                weatherLabel.text = weatherEvent.weather
                weatherLabel.font = UIFont.systemFontOfSize(15)
            }
        }
    }
    
}