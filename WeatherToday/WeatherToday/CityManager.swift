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
        let citysList = CityListProvider()
        citysInManage = citysList.citysInList
    }
    
    func getCitys() -> [CityInfo] {
        return self.citysInManage
    }
    
    func addCity(cityInfo: CityInfo, index: Int) {
        if (citysInManage.count >= index) {
            citysInManage.insert(cityInfo, atIndex: index)
        } else {
            citysInManage.append(cityInfo)
        }
    }
    
    func deleteCityAtIndex(index: Int) {
        citysInManage.removeAtIndex(index)
    }
}