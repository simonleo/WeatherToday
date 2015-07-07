//
//  LibraryAPI.swift
//  WeatherToday
//
//  Created by ls on 15/7/6.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import Foundation

public class LibraryAPI {
    
    private let cityListProvider: CityListProvider
    private let cityManager: CityManager
    private let weatherManager: WeatherManager
    
    private init(){
        cityManager = CityManager()
        weatherManager = WeatherManager()
        cityListProvider = CityListProvider()
    }
    
    //    单例模式 v1
    //    在 Swift 中可以无缝直接使用 GCD，所以我们可以很方便地用类似oc的方式用 Swift 写单例
    //    public class var defaultAPI: LibraryAPI {
    //        struct Static {
    //            static var onceToken: dispatch_once_t = 0
    //            static var staticInstance: LibraryAPI? = nil
    //        }
    //
    //        dispatch_once(&Static.onceToken) {
    //            Static.staticInstance = LibraryAPI()
    //        }
    //
    //        return Static.staticInstance!
    //    }
    
    //    单例模式 v2
    //    swift里let能保证线程安全，因此单例模式有更简单的写法
    public class var defaultAPI: LibraryAPI {
        struct Static {
            static let instance = LibraryAPI()
        }
        return Static.instance
    }
    
    // MARK: public methods
    public func getCityList() -> [CityInfo]{
        return cityListProvider.citysInList
    }
    
    public func addCityToManage(cityInfo: CityInfo) {
        cityManager.addCity(cityInfo)
    }
    
    public func getManagedCity() -> [CityInfo]{
         return cityManager.getCitys()
    }
    
    public func deleteManagedCity(cityInfo: CityInfo) {
        cityManager.deleteCity(cityInfo)
    }
    
    public func getManagedCityWeather(callback: [WeatherEvent] ->()) {
        let citysInManage = self.getManagedCity()
        var cityWeatherEvents = [WeatherEvent]()
        for city in citysInManage {
            weatherManager.getEvents(city.pinyin, callback: {
                weatherEvent in
                cityWeatherEvents.append(weatherEvent)
                if(cityWeatherEvents.count == citysInManage.count) {
                   callback(cityWeatherEvents)
                }
            })
        }
    }
    
    public func getCityWeatherForToday(callback: WeatherEvent ->()) {
        weatherManager.getEvents("beijing", callback: {
            weatherEventForToday in
            callback(weatherEventForToday)
        })
        
    }
    
    public func isManagedListIncludeCity(cityInfo: CityInfo) -> Bool {
        return cityManager.isManagedListIncludeCity(cityInfo)
    }
}

