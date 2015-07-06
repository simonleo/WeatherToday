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
    
    
    
    let weatherManager = WeatherManager.sharedManager
    let cityPinyin = "beijing"
    var weatherEvent: WeatherEvent? = nil {
        didSet {
            if let event = self.weatherEvent {
                dispatch_async(dispatch_get_main_queue()) {
                    self.cityLabel.text = event.city
                    self.weatherLabel.text = event.weather

                }
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
//        self.cityList = CityListManager()
//        self.preferredContentSize = CGSizeMake(0, 200);
//        var cityInfo = cityList?.citys[0]
//        weatherManager.getEvents(cityInfo!, callback: {
//            weatherEvent in
//            self.weatherEvent = weatherEvent
//        })
//        self.caretButton.backgroundColor = UIColor.clearColor()

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
        
        
        weatherManager.getEvents(cityPinyin, callback: {
            weatherEvent in
            self.weatherEvent = weatherEvent
        })

        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        let newInsets = UIEdgeInsets(top: defaultMarginInsets.top, left: defaultMarginInsets.left-30,
            bottom: defaultMarginInsets.bottom, right: defaultMarginInsets.right)
        return newInsets
    }
    
    @IBAction func onButtonTouch(sender: UIButton) {
        let url = NSURL(scheme: "weathertoday", host: nil, path: "/\(self.cityPinyin)")
        let cityPinyin = url!.lastPathComponent
        extensionContext?.openURL(url!, completionHandler: nil)

    }
}
