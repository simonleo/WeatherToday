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
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var caretButton: UIButton!
    
    let defaultAPI = LibraryAPI.defaultAPI
    var weatherEvent: WeatherEvent? = nil {
        didSet {
            if let event = self.weatherEvent {
                dispatch_async(dispatch_get_main_queue()) {
                    self.cityLabel.text = event.cityName
                    self.weatherLabel.text = event.weather

                }
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        defaultAPI.getCityWeatherForToday({
                weatherEventForToday in
                self.weatherEvent = weatherEventForToday
            })
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
        
        defaultAPI.getCityWeatherForToday({
            newEvent in
            if newEvent != self.weatherEvent {
                self.weatherEvent = newEvent
                completionHandler(NCUpdateResult.NewData)
            } else {
                completionHandler(NCUpdateResult.NoData)
            }
        })
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        let newInsets = UIEdgeInsets(top: defaultMarginInsets.top, left: defaultMarginInsets.left-30,
            bottom: defaultMarginInsets.bottom, right: defaultMarginInsets.right)
        return newInsets
    }
    
    @IBAction func onButtonTouch(sender: UIButton) {
        let url = NSURL(scheme: "weathertoday", host: nil, path: "/beijing")
        extensionContext?.openURL(url!, completionHandler: nil)

    }
}
