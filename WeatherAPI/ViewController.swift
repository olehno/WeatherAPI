//
//  ViewController.swift
//  WeatherAPI
//
//  Created by Артур Олехно on 11/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var weather: Weather?
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "temp"
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Location"
        return label
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search weather in your city"
        controller.searchBar.searchBarStyle = .default
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        view.addSubview(tempLabel)
        view.addSubview(locationLabel)
        
        constraints()
    }
    
    private func constraints() {
        let tempLabelConstraints = [
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        let locationLabelConstraints = [
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        ]
        NSLayoutConstraint.activate(tempLabelConstraints)
        NSLayoutConstraint.activate(locationLabelConstraints)
    }
    


}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text else {return}
        APICaller.shared.getCircuits(query: query) { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.tempLabel.text = String(weather.current.temp_c)
                    self.locationLabel.text = weather.location.name
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

