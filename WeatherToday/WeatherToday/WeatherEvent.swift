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
    public var city: String
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
    
    init(city: String, weather: String, l_tmp: Int, h_tmp: Int, date: String){
        self.city = city
        self.weather = weather
        self.l_tmp = l_tmp
        self.h_tmp = h_tmp
        self.date = date
    }
    
    public convenience init(json: JSONValue) {
        let data = WeatherEvent.extractDataFromJson(json)
        self.init(city: data.city, weather: data.weather, l_tmp: data.l_tmp, h_tmp: data.h_tmp, date: data.date)
    }
    
    class func extractDataFromJson(jsonEvent: JSONValue) -> (city: String, weather: String, l_tmp: Int, h_tmp: Int, date: String) {
        let city = jsonEvent["retData"]["city"].string!
        let weather = jsonEvent["retData"]["weather"].string!
        let l_tmp = jsonEvent["retData"]["l_tmp"].integer!
        let h_tmp = jsonEvent["retData"]["h_tmp"].integer!
        let dateString = jsonEvent["retData"]["date"].string!
        
        return (city, weather, l_tmp, h_tmp, dateString)
    }
}

//  extension
extension WeatherEvent: Equatable {
}

public func ==(lhs: WeatherEvent, rhs: WeatherEvent) -> Bool {
    return (lhs.weather == rhs.weather) && (lhs.city == rhs.city)
}
