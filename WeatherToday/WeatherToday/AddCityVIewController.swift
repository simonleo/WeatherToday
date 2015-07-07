//
//  AddCityVIewController.swift
//  WeatherToday
//
//  Created by ls on 15/7/7.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit
import WeatherTodayManageKit

protocol AddCityDelegate {
    func updateManagedCity(managedCitys: [CityInfo])
}

class AddCityViewController: UITableViewController {
    let defaultAPI = LibraryAPI.defaultAPI
    var citys = [CityInfo]() {
        didSet {
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    var managedCitys = [CityInfo]()
    var delegate: AddCityDelegate!
    
    override func awakeFromNib() {
        title = "CityList"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.managedCitys = defaultAPI.getManagedCity()
        self.citys = defaultAPI.getCityList()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citys.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath) as! UITableViewCell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cityCell = cell as? CityTableViewCell {
            let cityInfo = self.citys[indexPath.row]
            cityCell.cityInfo = cityInfo
            cityCell.isChoosed = defaultAPI.isManagedListIncludeCity(cityInfo)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cityCell = self.tableView.cellForRowAtIndexPath(indexPath)
        let citySelected = self.citys[indexPath.row]
        if let cityCell = cityCell as? CityTableViewCell {
            var isChoosed = cityCell.isChoosed
            if isChoosed! {
                defaultAPI.deleteManagedCity(citySelected)
                cityCell.isChoosed = false
            } else {
                defaultAPI.addCityToManage(citySelected)
                cityCell.isChoosed = true
            }
        }
    }

    override func viewDidDisappear(animated: Bool) {
        self.managedCitys = defaultAPI.getManagedCity()
        delegate?.updateManagedCity(managedCitys)
        super.viewDidDisappear(animated)
    }
}