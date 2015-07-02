//
//  TodayViewController.swift
//  WeatherTodayWidget
//
//  Created by ls on 15/7/2.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherTodayManageKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    let weatherManager = WeatherManager()
    var cityList: CityListManager? = nil
    var weatherEvent: WeatherEvent? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        self.cityList = CityListManager()
        var cityInfo = cityList?.citys[0]
        weatherManager.getEvents(cityInfo!, callback: {
            weatherEvent in
            self.weatherEvent = weatherEvent
        })

        completionHandler(NCUpdateResult.NewData)
    }
    
}
