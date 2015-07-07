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

    @IBOutlet weak var choosedLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var cityInfo: CityInfo? {
        didSet {
            cityLabel.text = cityInfo?.cityName
            cityLabel.font = UIFont.systemFontOfSize(15)
        }
    }
    
    var isChoosed: Bool? {
        didSet {
            if isChoosed! {
                choosedLabel.text = "on"
                choosedLabel.textColor = UIColor.blueColor()
            } else {
                choosedLabel.text = "off"
                choosedLabel.textColor = UIColor.blackColor()
            }
        }
    }
    
}