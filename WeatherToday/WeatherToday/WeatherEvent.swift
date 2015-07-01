//
//  WeatherEvent.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import Foundation

public enum City: String {
    case beijing = "beijing"
    case shanghai = "shanghai"
    case guangzhou = "guangzhou"
    case other = "other"
}

public class WeatherEvent {
//    var pinyin: City
    var city: String
    var weather: String
    var l_tmp: Int
    var h_tmp: Int
    var date: NSDate?
    private class var dateFormatter : NSDateFormatter {
        struct Static {
            static let instance : NSDateFormatter = NSDateFormatter()
        }
        return Static.instance
    }
    
    init(city: String, weather: String, l_tmp: Int, h_tmp: Int, date: NSDate){
//        self.pinyin = pinyin
        self.city = city
        self.weather = weather
        self.l_tmp = l_tmp
        self.h_tmp = h_tmp
        self.date = date
    }
    
    public convenience init(json: JSONValue) {
        let data = WeatherEvent.extractDataFromJson(json)
        self.init(city: data.city, weather: data.weather, l_tmp: data.l_tmp, h_tmp: data.h_tmp, date: data.date!)
    }
    
    class func extractDataFromJson(jsonEvent: JSONValue) -> (city: String, weather: String, l_tmp: Int, h_tmp: Int, date: NSDate?) {
        let city = jsonEvent["retData"]["city"].string!
        let weather = jsonEvent["retData"]["weather"].string!
        let l_tmp = jsonEvent["retData"]["l_tmp"].integer!
        let h_tmp = jsonEvent["retData"]["h_tmp"].integer!
        
//        var cityPinyin: City = .other
//        if let pinyinString = jsonEvent["retData"]["pinyin"].string {
//            switch pinyinString {
//            case "beijing":
//                cityPinyin = .beijing
//            case "shanghai":
//                cityPinyin = .shanghai
//            case "guangzhou":
//                cityPinyin = .guangzhou
//            default:
//                cityPinyin = .other
//            }
//        }
        
        var date: NSDate?
        if let dateString = jsonEvent["retData"]["date"].string {
            WeatherEvent.dateFormatter.dateFormat = "yyyy-MM-dd"
            date = WeatherEvent.dateFormatter.dateFromString(dateString)
        }
        
        return (city, weather, l_tmp, h_tmp, date)
    }
}
