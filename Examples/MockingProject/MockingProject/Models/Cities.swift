//
//  Cities.swift
//  ApplicationReddMock
//
//  Created by iragam reddy, sreekanth reddy on 8/3/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

struct Cities: Decodable {
    let cities: [String]
}

struct CityDetails: Decodable {
    let name: String
    let weather: String
    let population: Int
    let counties: Int
}
