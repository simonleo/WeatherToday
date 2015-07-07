//
//  WeatherManager.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import Foundation


class WeatherManager {
    
    init(){
        
    }
    
    func getEvents(pinyin: String, callback: WeatherEvent->()) {
        
        let url = NSURL(string: "http://apistore.baidu.com/microservice/weather?citypinyin=\(pinyin)")
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
