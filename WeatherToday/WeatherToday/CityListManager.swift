//
//  CityListManager.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit

public struct CityInfo {
    public let pinyin: City
    public let city: String
    public let nickName: String
    public let imageName: String
    
    public var image: UIImage {
        return UIImage(named: imageName)!
    }
    
    public init(dictionary: [String:String]) {
        var cityPinyin = dictionary["pinyin"]!
        switch cityPinyin {
        case "beijing":
            pinyin = .beijing
        case "shanghai":
            pinyin = .shanghai
        case "guangzhou":
            pinyin = .guangzhou
        default:
            pinyin = .other
        }
        city = dictionary["city"]!
        nickName = dictionary["nickName"]!
        imageName = dictionary["imageName"]!
    }
}

public class CityListManager {
    public var citys = [CityInfo]()
    
    init(plistNamed: String) {
        self.citys = self.loadCityInfoFromPlistNamed(plistNamed)
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
