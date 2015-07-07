//
//  CityListManager.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit

public struct CityInfo {
    public let pinyin: String
    public let cityName: String
    
    public init(dictionary: [String:String]) {
        self.pinyin = dictionary["pinyin"]!
        self.cityName = dictionary["city"]!
    }
}

public class CityListProvider {
    public var citysInList = [CityInfo]()
    
    init(plistNamed: String) {
        self.citysInList = self.loadCityInfoFromPlistNamed(plistNamed)
    }
    
    public convenience init() {
        self.init(plistNamed: "CityList")
    }
    
    private func loadCityInfoFromPlistNamed(plistName: String) -> [CityInfo] {
        let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist")
        var citys = [CityInfo]()
        if let rawArray = NSArray(contentsOfFile: path!) {
            for rawCity in rawArray as![[String:String]] {
                citys.append(CityInfo(dictionary: rawCity))
            }
        }
        return citys
    }
}
