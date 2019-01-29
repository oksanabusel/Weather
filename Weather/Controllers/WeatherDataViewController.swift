//
//  WeatherDataViewController.swift
//  Weather
//
//  Created by Cat on 1/21/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class WeatherDataViewController: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxMinTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicatorStartAnimating()
        
        Request.sendRequest(link: url) { data in
            guard let parsedData = data,
                let receivedData = Parser.parse(receivedData: parsedData) else {
                    self.showAlert()
                    return
            }
            DispatchQueue.main.async {
                self.activityIndicatorStopAnimating()
                self.fillInformationFields(data: receivedData)
                self.setCurrentDate()
                self.setImage(data: receivedData)
            }
        }
    }
    
    private func fillInformationFields(data: WeatherData) {
        let temperature = Int(data.main.temp)
        let maxTemp     = Int(data.main.tempMax)
        let minTemp     = Int(data.main.tempMin)
        let humidity    = Int(data.main.humidity)
        
        self.cityNameLabel.text          = data.name
        self.temperatureLabel.text       = String(temperature) + StringModificators.сelsiusSign
        self.maxMinTemperatureLabel.text = String(maxTemp) + StringModificators.space + String(minTemp)
        self.humidityLabel.text          = String(humidity) + StringModificators.persents
        self.windSpeedLabel.text         = String(data.wind.speed) + StringModificators.metersPerSecond
    }
    
    private func setCurrentDate() {
        let date      = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yy"
        let result = formatter.string(from: date)
        self.currentDateLabel.text = result
    }
    
    private func activityIndicatorStartAnimating() {
        self.visualEffectView.isHidden  = true
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    private func activityIndicatorStopAnimating() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.visualEffectView.isHidden  = false
    }
    
    private func setImage(data: WeatherData) {
        if data.weather[0].main == WeatherParameters.snow {
            self.weatherImage.image = #imageLiteral(resourceName: "Snow")
        } else if data.weather[0].main == WeatherParameters.fewClouds {
            self.weatherImage.image = #imageLiteral(resourceName: "FewClouds")
        } else if data.weather[0].main == WeatherParameters.scatteredClouds {
            self.weatherImage.image = #imageLiteral(resourceName: "FewClouds")
        } else if data.weather[0].main == WeatherParameters.clouds {
            self.weatherImage.image = #imageLiteral(resourceName: "BrokenClouds")
        } else if data.weather[0].main == WeatherParameters.showerRain {
            self.weatherImage.image = #imageLiteral(resourceName: "ShowerRain")
        } else if data.weather[0].main == WeatherParameters.rain {
            self.weatherImage.image = #imageLiteral(resourceName: "Rain")
        } else if data.weather[0].main == WeatherParameters.thunderstorm {
            self.weatherImage.image = #imageLiteral(resourceName: "Thunderstorm")
        } else if data.weather[0].main == WeatherParameters.clear {
            self.weatherImage.image = #imageLiteral(resourceName: "Sun")
        } else {
            self.weatherImage.image = #imageLiteral(resourceName: "Mist")
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: AlertMessages.errorTitle,
                                    message: AlertMessages.requestFail,
                             preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AlertMessages.okTitle,
                                      style: UIAlertAction.Style.default,
                                    handler: nil))
        self.present(alert, animated: true,
                          completion: nil)
    }
    
    @IBAction func tapChooseCityButton(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "fromWeatherScreen")
        self.dismiss(animated: true, completion: nil)
    }
    
}
