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
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var cityInfo: CityInfo? {
        didSet {
            if let cityInfo = cityInfo {
                cityNameLabel.text = cityInfo.city
                cityNameLabel.font = UIFont.systemFontOfSize(15)
                nickNameLabel.text = cityInfo.nickName
                nickNameLabel.font = UIFont.systemFontOfSize(10)
            }
        }
    }
    
}