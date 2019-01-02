//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by Simon Ng on 16/10/2015.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherInfoKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var cityLabel:UILabel!
    @IBOutlet var weatherLabel:UILabel!
    @IBOutlet var temperatureLabel:UILabel!
    
    var location = "Paris, France"
    var defaults = NSUserDefaults(suiteName: "group.com.appcoda.weatherdemo")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.text = location
        
        // Invoke weather service to get the weather data
        WeatherService.sharedWeatherService().getCurrentWeather(location) { (data) -> () in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let weatherData = data {
                    self.weatherLabel.text = weatherData.weather.capitalizedString
                    self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        // Get the location from defaults
        if let defaultLocation = defaults.valueForKey("location") as? String {
            location = defaultLocation
        }

        cityLabel.text = location
        
        WeatherService.sharedWeatherService().getCurrentWeather(location) { (data) -> () in
            guard let weatherData = data else {
                completionHandler(NCUpdateResult.NoData)
                return
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.weatherLabel.text = weatherData.weather.capitalizedString
                self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
            })
            
            completionHandler(NCUpdateResult.NewData)
        }
    }
    
}
