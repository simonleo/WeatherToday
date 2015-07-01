//
//  WeatherEvent.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import Foundation

enum City: String {
    case Beijing = "beijing"
    case Shanghai = "shanghai"
    case Guangzhou = "guangzhou"
    case Other = "other"
}

class WeatherEvent {
    var pinyin: String
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
    
    init(pinyin: String, city: String, weather: String, l_tmp: Int, h_tmp: Int, date: NSDate){
        self.pinyin = pinyin
        self.city = city
        self.weather = weather
        self.l_tmp = l_tmp
        self.h_tmp = h_tmp
        self.date = date
    }
    
    convenience init(json: JSONValue) {
        let data = WeatherEvent.extractDataFromJson(json)
        self.init(pinyin: data.pinyin, city: data.city, weather: data.weather, l_tmp: data.l_tmp, h_tmp: data.h_tmp, date: data.date)
    }
    
    class func extractDataFromJson(jsonEvent: JSONValue) -> (pinyin: String, city: String, weather: String, l_tmp: Int, h_tmp: Int, date: NSDate) {
        let city = jsonEvent["city"].string
        let weather = jsonEvent["weather"].string
        let l_tmp = jsonEvent["l_tmp"].integer
        let h_tmp = jsonEvent["h_tmp"].integer
        
        var cityPinyin: City = .Other
        if let pinyinString = jsonEvent["pinyin"].string {
            switch pinyinString {
            case "beijing":
                cityPinyin = .Beijing
            case "shanghai":
                cityPinyin = .Shanghai
            case "guangzhou":
                cityPinyin = .Guangzhou
            default:
                cityPinyin = .Other
            }
        }
        
        var date: NSDate?
        if let dateString = jsonEvent["date"].string {
            WeatherEvent.dateFormatter.dateFormat = "yyyy-MM-dd"
            date = WeatherEvent.dateFormatter.dateFromString(dateString)
        }
        
        return (cityPinyin, city, weather, l_tmp, h_tmp, date)
    }
}
