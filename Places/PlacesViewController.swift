//
//  ViewController.swift
//  Places
//
//  Created by Богдан Маншилин on 14/07/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import class Alamofire.SessionManager

class PlacesViewController: UITableViewController {
    
    enum Constatns {
        static let reuseIdentifier = String(describing: PlaceTableViewCell.self)
    }

    var placesService: PlacesServiceProtocol!
    var picturesService: PicturesServiceProtocol!
    
    var places: [Place] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: Constatns.reuseIdentifier)
        loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = places[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constatns.reuseIdentifier) as! PlaceTableViewCell
        
        cell.name.text = place.name
        cell.placeDescription.text = place.description
        
        let size = PlaceTableViewCell.Constants.pictureSize
        let scaledSize = size * UIScreen.main.scale
        
        if let url = place.picture.url(scaledSize) {
            picturesService.setImage(from: url, to: cell.picture)
        }
        
        return cell
    }

    func present(error: Error, action: (title: String, handler: (UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: action.title, style: .default, handler: action.handler))
        show(alert, sender: nil)
    }
    
}

extension PlacesViewController {
    func loadData() {
        placesService.places { [weak self] result in
            switch result {
            case .success(let places):
                self?.places = places
            case .failure(let error):
                self?.present(error: error, action: (title: "Попробовать снова", handler: { _ in
                    self?.loadData()
                }))
            }
        }
    }
}
