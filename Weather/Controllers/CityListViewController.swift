//
//  CityListViewController.swift
//  Weather
//
//  Created by Cat on 1/21/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var citiesListTableView: UITableView!
    
    private var tableData: [String]  = []
    private var searchCity: [String] = []
    private var searchResult: Bool   = false
    private let defaults             = UserDefaults.standard
    private var selectedRowIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.barTintColor = UIColor.clear
        
        JsonParser.getCitiesList()
        tableData = Storage.shared.dataList
        citiesListTableView.reloadData()
        self.setupHideKeyboardOnTap()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backgroundImage = UIImage(named: "sunrise2.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.alpha = 0.7
        citiesListTableView.backgroundView = imageView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkTheFavoriteCity()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toMainScreenSegue {
            if selectedRowIndex != nil {
                if searchResult {
                    var cityName = searchCity[selectedRowIndex ?? 0]
                    cityName = cityName.components(separatedBy: ",")[0]
                    defaults.set(cityName, forKey: "chosenCity")
                    UserDefaults.standard.set(false, forKey: "fromWeatherScreen")
                    LinkService.createURL(city: cityName)
                } else {
                    var cityName = tableData[selectedRowIndex ?? 0]
                    cityName = cityName.components(separatedBy: ",")[0]
                    defaults.set(cityName, forKey: "chosenCity")
                    UserDefaults.standard.set(false, forKey: "fromWeatherScreen")
                    LinkService.createURL(city: cityName)
                }
            }
        }
    }
    
    private func checkTheFavoriteCity() {
        if let cityName = UserDefaults.standard.value(forKey: "chosenCity") as? String {
            LinkService.createURL(city: cityName)
            if UserDefaults.standard.bool(forKey: "fromWeatherScreen") {
            } else {
                performSegue(withIdentifier: toMainScreenSegue, sender: self)
            }
        }
    }
   
}

extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResult {
            return searchCity.count
        } else {
            return tableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityNameCell
        if searchResult {
            cell.cityNameLabel.text = searchCity[indexPath.row]
        } else {
            cell.cityNameLabel.text = tableData[indexPath.row]
        }
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle  = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
}

extension CityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! CityNameCell
        selectedCell.leftRoundViewConstraint.constant  = 5
        selectedCell.rightRoundViewConstraint.constant = 5
        selectedCell.cityNameLabel.textColor = UIColor.yellow
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let deselectedCell = self.citiesListTableView.cellForRow(at: indexPath) as? CityNameCell  {
            deselectedCell.cityNameLabel.textColor = UIColor.white
            deselectedCell.leftRoundViewConstraint.constant  = 50
            deselectedCell.rightRoundViewConstraint.constant = 50
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRowIndex = indexPath.row
        
        return indexPath
    }
    
}

extension CityListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCity = tableData.filter({$0.prefix(searchText.count) == searchText})
        searchResult = true
        citiesListTableView.reloadData()
    }
    
}

extension CityListViewController {
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        
        return tap
    }
    
}
