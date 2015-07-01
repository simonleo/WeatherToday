//
//  WeatherManager.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import Foundation

public class WeatherManager {
    public init() {}
    
    public func getEvents(cityInfo: CityInfo, callback: (WeatherEvent)->()) {
        
        let url = NSURL(string: "http://apistore.baidu.com/microservice/weather?citypinyin=\(cityInfo.pinyin.rawValue)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!,completionHandler: {
                (data, response, error) in
            if(error != nil) {
                println("Error: \(error.localizedDescription)")
                return
            }
            let events = self.convertJSONToEvents(JSONValue(data))
            callback(events)
        })
        task.resume()
    }
    
    private func convertJSONToEvents(data:JSONValue) -> WeatherEvent {
        let weatherEvent = WeatherEvent(json: data)
        
        return weatherEvent
    }
}
