//
//  WeatherModel.swift
//  ClimaMyOwnTake
//
//  Created by Vinojen Gengatharan on 2020-08-01.
//  Copyright © 2020 Vinojen Gengatharan. All rights reserved.
//

import Foundation
struct WeatherData : Decodable
{
    let coord : coord
    let name : String
    let weather : [weather]
    let main : main
}
