//
//  ViewController.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var cityList: CityListManager? = nil
    
    override func awakeFromNib() {
        title = "WeatherToday"
        cityList = CityListManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList?.citys.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath) as! UITableViewCell
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cityCell = cell as? CityTableViewCell {
            let cityInfo = cityList?.citys[indexPath.row]
            cityCell.cityInfo = cityInfo
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cityInfo = cityList?.citys[indexPath.row]
        let weatherViewController = storyboard?.instantiateViewControllerWithIdentifier("WeatherViewController") as? WeatherViewController
        if let weatherViewController = weatherViewController {
            weatherViewController.cityInfo = cityInfo
            navigationController?.pushViewController(weatherViewController, animated: true)
        }
    }

}

