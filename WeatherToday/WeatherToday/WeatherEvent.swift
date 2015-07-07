//
//  WeatherEvent.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import Foundation


public class WeatherEvent {
    public var pinyin: String
    public var cityName: String
    public var weather: String
    public var l_tmp: Int
    public var h_tmp: Int
    public var date: String
    private class var dateFormatter : NSDateFormatter {
        struct Static {
            static let instance : NSDateFormatter = NSDateFormatter()
        }
        return Static.instance
    }
    
    init(pinyin: String, cityName: String, weather: String, l_tmp: Int, h_tmp: Int, date: String){
        self.cityName = cityName
        self.weather = weather
        self.l_tmp = l_tmp
        self.h_tmp = h_tmp
        self.date = date
        self.pinyin = pinyin
    }
    
    public convenience init(json: JSONValue) {
        let data = WeatherEvent.extractDataFromJson(json)
        self.init(pinyin: data.pinyin, cityName: data.cityName, weather: data.weather, l_tmp: data.l_tmp, h_tmp: data.h_tmp, date: data.date)
    }
    
    class func extractDataFromJson(jsonEvent: JSONValue) -> (pinyin: String, cityName: String, weather: String, l_tmp: Int, h_tmp: Int, date: String) {
        let cityName = jsonEvent["retData"]["city"].string!
        let weather = jsonEvent["retData"]["weather"].string!
        let l_tmp = jsonEvent["retData"]["l_tmp"].integer!
        let h_tmp = jsonEvent["retData"]["h_tmp"].integer!
        let dateString = jsonEvent["retData"]["date"].string!
        let pinyin = jsonEvent["retData"]["pinyin"].string!
        
        return (pinyin,cityName, weather, l_tmp, h_tmp, dateString)
    }
}

//  extension
extension WeatherEvent: Equatable {
}

public func ==(lhs: WeatherEvent, rhs: WeatherEvent) -> Bool {
    return (lhs.weather == rhs.weather) && (lhs.cityName == rhs.cityName)
}
