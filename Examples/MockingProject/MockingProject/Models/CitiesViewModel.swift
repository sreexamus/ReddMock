//
//  CitiesViewModel.swift
//  ApplicationReddMock
//
//  Created by iragam reddy, sreekanth reddy on 8/3/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import Foundation

class CitiesViewModel {
    func getCities(completion: @escaping (Cities) -> Void) {
        //https://test.com/getcities
        URLSession.shared.dataTask(with: URL(string: "https://test.com/getcities")!) { (data, res, err) in
            DispatchQueue.main.async {
                let cities = try? JSONDecoder().decode(Cities.self, from: data!)
                if let citiesData = cities {
                    completion(citiesData)
                }
            }
        }.resume()
    }
    
    func getCityDetails(completion: @escaping (CityDetails) -> Void) {
        //https://test.com/getcities
        URLSession.shared.dataTask(with: URL(string: "https://test.com/getcitidetails")!) { (data, res, err) in
            DispatchQueue.main.async {
                 let cities = try? JSONDecoder().decode(CityDetails.self, from: data!)
                completion(cities!)
            }
        }.resume()
    }
}
