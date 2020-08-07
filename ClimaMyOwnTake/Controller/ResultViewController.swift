//
//  ResultViewController.swift
//  ClimaMyOwnTake
//
//  Created by Vinojen Gengatharan on 2020-08-03.
//  Copyright © 2020 Vinojen Gengatharan. All rights reserved.
//

import UIKit
class ResultViewController : UIViewController
{
    //IB Outlet Collection
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // variables
    var lowTemperatureString : String?
    var highTemperatureString : String?
    var descriptionLabelString : String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        lowTemperatureLabel.text = lowTemperatureString!
        highTemperatureLabel.text = highTemperatureString!
        descriptionLabel.text = descriptionLabelString!
    }
    
    @IBAction func backPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
