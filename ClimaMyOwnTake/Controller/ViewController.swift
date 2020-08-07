//
//  ViewController.swift
//  ClimaMyOwnTake
//
//  Created by Vinojen Gengatharan on 2020-08-01.
//  Copyright © 2020 Vinojen Gengatharan. All rights reserved.
//

import UIKit
import CoreLocation



class ViewController: UIViewController{
    
    // variables
    var weatherManagerHandle : WeatherManager = WeatherManager()
    let locationManager : CLLocationManager = CLLocationManager()
    var weatherModelToUseForSegue : WeatherModel?
    
    // IB Outlets
    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    //IB Methods
    @IBAction func searchCity(_ sender: UIButton)
    {
        let cityName : String = searchInput.text!
        weatherManagerHandle.performTask(cityName: cityName)
    }
    
    @IBAction func locationPressed(_ sender: UIButton)
    {
        locationManager.requestLocation()
        
    }
    
    @IBAction func moreDetailsPressed(_ sender: UIButton)
    {
        if weatherModelToUseForSegue != nil
        {
            performSegue(withIdentifier: "transistionToDetails", sender: self)
        }
    }
    
    // functions
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchInput.delegate = self
        weatherManagerHandle.weatherUpdateDelegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // methods for SEGUE    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "transistionToDetails")
        {
            print("prepare for segue method is being called.")
            let destinationViewController = segue.destination as! ResultViewController
            destinationViewController.descriptionLabelString = weatherModelToUseForSegue?.description
            destinationViewController.highTemperatureString = String(format: "%.0f", weatherModelToUseForSegue!.temperatureMax)
            destinationViewController.lowTemperatureString = String(format: "%.0f", weatherModelToUseForSegue!.temperatureMinRounded)
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        searchInput.resignFirstResponder()
        return true
    }
}



// MARK: - UpdateWeather
extension ViewController : updateWeather
{
    func updateWeather(_ weatherModelToUse: WeatherModel)
    {
        cityName.text = weatherModelToUse.name
        temperatureLabel.text = String(weatherModelToUse.temperatureAsInt)
        let sFSymbolName = weatherModelToUse.sFsymbol
        weatherIcon.image = UIImage(systemName: sFSymbolName)
        weatherModelToUseForSegue = weatherManagerHandle.getWeatherModel(weatherModelToReturn: weatherModelToUse)
        print(weatherModelToUseForSegue!)
    }
}

// MARK: - locationManager
extension ViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("We were unable to obtain your location.")
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("Location obtained.")
        if let location = locations.last
        {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherManagerHandle.performTaskWithCoordinates(longitude, latitude)
        }
    }
}

