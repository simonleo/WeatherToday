//
//  CityManager.swift
//  WeatherToday
//
//  Created by ls on 15/7/6.
//  Copyright (c) 2015年 ls. All rights reserved.
//

import Foundation

class CityManager {
    private var citysInManage = [CityInfo]()

    init() {
//        let citysList = CityListProvider()
//        citysInManage = citysList.citysInList
    }
    
    func getCitys() -> [CityInfo] {
        return self.citysInManage
    }
    
    func addCity(cityInfo: CityInfo) {
        for city in citysInManage {
            if city == cityInfo {
            return
            }
        }
        citysInManage.append(cityInfo)
    }
    
    func deleteCity(cityInfo: CityInfo) {
        var index = 0
        for city in citysInManage {
            if city == cityInfo {
                self.citysInManage.removeAtIndex(index)
                return
            }
            index++
        }
    }
    
    func isManagedListIncludeCity(cityInfo: CityInfo) -> Bool {
        for city in citysInManage {
            if city == cityInfo {
                return true
            }
        }
        return false
    }
}