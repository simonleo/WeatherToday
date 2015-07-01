//
//  CityListManager.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import UIKit

struct CityInfo {
    let pinyin: City
    let city: String
    let nickName: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName)!
    }
    
    init(dictionary: [String:String]) {
        if var cityPinyin = dictionary["pinyin"] {
            switch cityPinyin {
            case "beijing":
                pinyin = .Beijing
            case "shanghai":
                pinyin = .Shanghai
            case "guangzhou":
                pinyin = .Guangzhou
            default:
                pinyin = .Other
            }
        }
        city = dictionary["city"]!
        nickName = dictionary["nickName"]!
        imageName = dictionary["imageName"]!
    }
}

class CityListManager {
    private(set) var citys = [CityInfo]()
    
    init(plistNamed: String) {
        self.citys = self.loadCityInfoFromPlistNamed(plistNamed)
    }
    
    convenience init() {
        self.init(self.init(plistNamed: "CityList"))
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
