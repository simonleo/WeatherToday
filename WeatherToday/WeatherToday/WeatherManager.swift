//
//  WeatherManager.swift
//  WeatherToday
//
//  Created by ls on 15/7/1.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import Foundation

//    单例模式 v2
//    swift里let能保证线程安全，因此单例模式有更简单的写法
//    由于现在 class 不支持存储式的 property，我们想要使用一个只存在一份的属性时，就只能将其定义在全局的 scope 中
//    在 Swift 拥有访问级别控制后，我们可以在变量定义前面加上 private 关键字，使这个变量只在当前文件中可以被访问
private let sharedInstance = WeatherManager()

public class WeatherManager {
    
//    单例模式 v1
//    在 Swift 中可以无缝直接使用 GCD，所以我们可以很方便地用类似oc的方式用 Swift 写单例
//    public class var sharedManager: WeatherManager {
//        struct Static {
//            static var onceToken: dispatch_once_t = 0
//            static var staticInstance: WeatherManager? = nil
//        }
//        
//        dispatch_once(&Static.onceToken) {
//            Static.staticInstance = WeatherManager()
//        }
//        
//        return Static.staticInstance!
//    }
    
//    单例模式 v2
    public class var sharedManager: WeatherManager {
        return sharedInstance
    }
    
    public func getEvents(pinyin: String, callback: WeatherEvent->()) {
        
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
