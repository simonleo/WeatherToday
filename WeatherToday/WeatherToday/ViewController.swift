//
//  ViewController.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit
import WeatherTodayManageKit

class ViewController: UITableViewController {

    let defaultAPI = LibraryAPI.defaultAPI
    var cityWeatherEvents = [WeatherEvent]() {
        didSet {
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        title = "WeatherToday"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        defaultAPI.getManagedCityWeather({
          cityWeatherEvents in
            self.cityWeatherEvents = cityWeatherEvents
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeatherEvents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath) as! UITableViewCell
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cityCell = cell as? CityTableViewCell {
            let cityWeatherEvent = self.cityWeatherEvents[indexPath.row]
            cityCell.cityWeatherEvent = cityWeatherEvent
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cityWeatherEvent = self.cityWeatherEvents[indexPath.row]
        let weatherViewController = storyboard?.instantiateViewControllerWithIdentifier("WeatherViewController") as? WeatherViewController
        if let weatherViewController = weatherViewController {
            weatherViewController.cityWeatherEvent = cityWeatherEvent
            navigationController?.pushViewController(weatherViewController, animated: true)
        }
    }

}

