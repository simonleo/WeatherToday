//
//  CityWeatherTableViewCell.swift
//  WeatherToday
//
//  Created by ls on 15/7/7.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit
import WeatherTodayManageKit

class CityWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!

    
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