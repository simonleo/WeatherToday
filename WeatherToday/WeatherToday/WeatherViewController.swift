//
//  WeatherViewController.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit
import WeatherTodayManageKit

enum Weather: String {
    case 晴 = "晴"
    case 多云 = "多云"
    case 阴 = "阴"
    case 阵雨 = "阵雨"
    case 雷阵雨 = "雷阵雨"
    case 雨 = "雨"
}

class WeatherViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var lowTmpLabel: UILabel!
    @IBOutlet weak var highTmpLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var cityPinyin: String!
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
                    var weather: Weather = .雨
                    if (event.weather == "晴") || (event.weather == "多云") || (event.weather == "阴") || (event.weather == "阵雨") || (event.weather == "雷阵雨") {
                        weather = Weather(rawValue: event.weather)!
                    }
                    self.updateWeatherImage(weather)
                } else {
                    println("weatherEvent is nil!")
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(cityPinyin != nil, "city not set")
        weatherManager = WeatherManager.sharedManager
        weatherManager.getEvents(cityPinyin!, callback: {
            weatherEvent in
            self.weatherEvent = weatherEvent
        })
        

    }
    
    func updateWeatherImage(weather: Weather) {
        switch weather {
        case .晴:
            self.weatherImageView.image = UIImage(named: "晴")
        case .多云:
            self.weatherImageView.image = UIImage(named: "多云")
        case .阴:
            self.weatherImageView.image = UIImage(named: "阴")
        case .阵雨:
            self.weatherImageView.image = UIImage(named: "阵雨")
        case .雷阵雨:
            self.weatherImageView.image = UIImage(named: "雷阵雨")
        default:
            self.weatherImageView.image = UIImage(named: "雨")
        }
    }
    
    

}