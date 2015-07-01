//
//  WeatherManager.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import Foundation

class WeatherManager {
    init() {}
    
    func getEvents(city: City, callback: (WeatherEvent)->()) {
        let url = NSURL(string: "http://apistore.baidu.com/microservice/weather?citypinyin=\(city)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!,completionHandler: {
                (data, response, error) in
            if(error != nil) {
                println("Error: \(error.localizedDescription)")
                return
            }
            let event = self.convertJSONToEvents(JSONValue(data))
            callback(event!)
        })
        task.resume()
    }
    
    private func convertJSONToEvents(data:JSONValue) -> WeatherEvent? {
        let jsons = data.array
        var weatherEvent: WeatherEvent?
        if let eventJson = jsons?[0] {
            weatherEvent = WeatherEvent(json: eventJson)
        }
        return weatherEvent
    }
}
