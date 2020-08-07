//
//  Main.swift
//  ClimaMyOwnTake
//
//  Created by Vinojen Gengatharan on 2020-08-01.
//  Copyright © 2020 Vinojen Gengatharan. All rights reserved.
//

import Foundation
struct main : Decodable
{
    var temp : Double
    var feels_like : Double
    var temp_min : Double
    var temp_max : Double
    var pressure : Int
    var humidity : Int
}
