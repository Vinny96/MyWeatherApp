//
//  Weather.swift
//  ClimaMyOwnTake
//
//  Created by Vinojen Gengatharan on 2020-08-01.
//  Copyright © 2020 Vinojen Gengatharan. All rights reserved.
//

import Foundation
struct weather : Decodable
{
    var id : Int
    var main : String
    var description : String
    var icon : String
}
