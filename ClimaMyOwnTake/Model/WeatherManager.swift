//
//  WeatherManager.swift
//  ClimaMyOwnTake
//
//  Created by Vinojen Gengatharan on 2020-08-01.
//  Copyright © 2020 Vinojen Gengatharan. All rights reserved.
//

import Foundation

protocol updateWeather
{
    func updateWeather(_ weatherModelToUse : WeatherModel)
}

struct WeatherManager
{
    // variables
    var weatherUpdateDelegate : updateWeather? // remember that the delegate is an object that adopts and conforms to the protocol. Here the implementation is in ViewController.
    
    // networking code
    let baseURL : String = "https://api.openweathermap.org/data/2.5/weather?&units=metric"
    let apiKey : String = "1b04d19c6212e94d99f5a5e654a1b9f3"
    func performTask(cityName : String) 
    {
        // Step 1 is to create a url
        let completeURL = "\(baseURL)&appid=\(apiKey)&q=\(cityName)"
        let fixedURL = completeURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: fixedURL!){
            // step 2 is to create a url session
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if(error != nil)
                {
                    print("An error was encountered in the networking session.")
                    print(error!)
                    return
                }
                if let safeData = data
                {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    if let weatherModelReturned : WeatherModel = self.parseJSON(weatherData: safeData)
                    {
                        DispatchQueue.main.async
                        {
                            self.weatherUpdateDelegate?.updateWeather(weatherModelReturned)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func performTaskWithCoordinates(_ longitude : Double, _ latitude : Double)
    {
        // step 1 is to create a url
        let completedURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(apiKey)"
        print(completedURL)
        if let url = URL(string: completedURL)
        {
            // step 2 is to create a url session
            let session = URLSession(configuration: .default)
            // step 3 is to create a task
            let task = session.dataTask(with: url) { (data,response, error) in
                if(error != nil)
                {
                    print(error!)
                    print("There was an error in the networking event.")
                    return
                }
                if let safeData = data
                {
                    if let weatherModelReturned = self.parseJSON(weatherData: safeData)
                    {
                        DispatchQueue.main.async
                        {
                            self.weatherUpdateDelegate?.updateWeather(weatherModelReturned)
                        }
                    }
                }
            }
            // step 4 is to start the task
            task.resume()
        }
    }
    
    
    // end of networking code
    func parseJSON(weatherData : Data) -> WeatherModel?
    {
        let decoder: JSONDecoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherModelToReturn : WeatherModel = WeatherModel(nameVal: decodedData.name, temperatureVal: decodedData.main.temp, temperatureMinVal: decodedData.main.temp_min, temperatureMaxVal: decodedData.main.temp_max, descriptionVal: decodedData.weather[0].description, idVal: decodedData.weather[0].id, longitudeVal: decodedData.coord.lon, latitudeVal: decodedData.coord.lat)
            return weatherModelToReturn
        }catch
        {
            print(error)
            print("An error occured while parsing the JSON.")
            return nil
        }
    }
    
    func getWeatherModel(weatherModelToReturn : WeatherModel) -> WeatherModel
    {
        return weatherModelToReturn
    }
}



