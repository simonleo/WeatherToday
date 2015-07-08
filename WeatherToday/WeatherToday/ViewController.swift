//
//  ViewController.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit
import WeatherTodayManageKit

class ViewController: UITableViewController, AddCityDelegate {

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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        showOrHideNavPrompt()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: tableView
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeatherEvents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("cityWeatherCell", forIndexPath: indexPath) as! UITableViewCell
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cityWeatherCell = cell as? CityWeatherTableViewCell {
            let cityWeatherEvent = self.cityWeatherEvents[indexPath.row]
            cityWeatherCell.cityWeatherEvent = cityWeatherEvent
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
    
    //MARK: target-action
    @IBAction func addCityButtonTouched(sender: UIButton) {
        let addCityViewController = storyboard?.instantiateViewControllerWithIdentifier("AddCityViewController") as? AddCityViewController
        if let viewController = addCityViewController {
            addCityViewController?.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func updateManagedCity() {
        let managedCitys = defaultAPI.getManagedCity()
        if managedCitys.count <= 0 {
            self.cityWeatherEvents = [WeatherEvent]()
        } else {
            defaultAPI.getManagedCityWeather({
                cityWeatherEvents in
                self.cityWeatherEvents = cityWeatherEvents
            })
        }
    }
    
    //MARK: private methods
    func showOrHideNavPrompt() {
        let count = self.defaultAPI.getManagedCity().count
        if count > 0 {
            self.navigationItem.prompt = nil
        } else {
            let delayInSeconds = 0.5
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()){
                self.navigationItem.prompt = "Add cities to show their weather!"
            }
        }
    }

}




