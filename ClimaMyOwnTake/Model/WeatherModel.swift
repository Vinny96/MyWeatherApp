//
//  WeatherModel.swift
//  ClimaMyOwnTake
//
//  Created by Vinojen Gengatharan on 2020-08-01.
//  Copyright © 2020 Vinojen Gengatharan. All rights reserved.
//

import Foundation
struct WeatherModel
{
    var name : String
    var temperature : Double
    var temperatureAsInt: Int
    {
        let temporaryTemp = temperature.rounded()
        return Int(temporaryTemp)
    }
    var temperatureMin : Double
    var temperatureMinRounded : Double
    {
        let temporaryTemp = temperatureMin.rounded()
        return Double(temporaryTemp)
    }
    var temperatureMax : Double
    var temperatureMaxRounded : Double
    {
        let temporaryTemp = temperatureMax.rounded()
        return Double(temporaryTemp)
    }
    var description : String
    var longitude : Double
    var latitude : Double
    var id : Int
    // need to implement the ID section and what the SF symbol will be
    var sFsymbol : String
    {
        switch id
        {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...771:
            return "smoke.fill"
        case 781:
            return "tornado.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "sun.max.fill"
        }
    }
    
    init(nameVal : String, temperatureVal : Double, temperatureMinVal : Double, temperatureMaxVal : Double, descriptionVal : String, idVal : Int, longitudeVal : Double, latitudeVal : Double)
    {
        name = nameVal
        temperature = temperatureVal
        temperatureMin = temperatureMinVal
        temperatureMax = temperatureMaxVal
        description = descriptionVal
        id = idVal
        longitude = longitudeVal
        latitude = latitudeVal
    }
}

