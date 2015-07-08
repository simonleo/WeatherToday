//
//  CityListManager.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit

public struct CityInfo : Equatable{
    public let pinyin: String
    public let cityName: String
    
    public init(dictionary: [String:String]) {
        self.pinyin = dictionary["pinyin"]!
        self.cityName = dictionary["city"]!
    }
}

public func ==(lhs: CityInfo, rhs: CityInfo) -> Bool{
    return (lhs.cityName == rhs.cityName) && (lhs.pinyin == rhs.pinyin)
}

class CityListProvider {
    var citysInList = [CityInfo]()
    
    init(plistNamed: String) {
        self.citysInList = self.loadCityInfoFromPlistNamed(plistNamed)
    }
    
    convenience init() {
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
