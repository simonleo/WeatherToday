//
//  CityTableViewCell.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var cityInfo: CityInfo? {
        didSet {
            if let cityInfo = cityInfo {
                cityNameLabel.text = cityInfo.city
            }
        }
    }
    
}