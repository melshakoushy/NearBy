//
//  ViewController.swift
//  NearBy
//
//  Created by Mahmoud Elshakoushy on 12/24/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import AlamofireImage

class MainVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var singleUpdateBtn: UIButton!
    
    //Constants
    let placeCellId = "PlaceCell"
    let noDataCellId = "NoDataCell"
    let errorCellId = "ErrorCell"
    let locationManager = CLLocationManager()
    
    //Variables
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distance: Double = 0.0
    var venus = [VenuModel]()
    var venuId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
        setupLocation()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnChange()
    }
    
    func btnChange() {
        if Helper.getBtnTitle() == "Realtime" {
            singleUpdateBtn.setTitle("Realtime", for: .normal)
        } else if Helper.getBtnTitle() == "" {
            singleUpdateBtn.setTitle("Single Update", for: .normal)
        }
    }
    
    func setupView() {
        self.singleUpdateBtn.clipsToBounds = true
        self.singleUpdateBtn.layer.cornerRadius = 7
    }
    
    
    func setupTableView() {
        tableView.register(UINib(nibName: placeCellId, bundle: nil), forCellReuseIdentifier: placeCellId)
        tableView.register(UINib(nibName: noDataCellId, bundle: nil), forCellReuseIdentifier: noDataCellId)
        tableView.register(UINib(nibName: errorCellId, bundle: nil), forCellReuseIdentifier: errorCellId)
    }
    
    @IBAction func singleUpdateBtnPressed(_ sender: Any) {
        if singleUpdateBtn.titleLabel?.text == "Single Update" {
            Helper.saveBtnTitle(title: "Realtime")
            restartApp()
        }
        if singleUpdateBtn.titleLabel?.text == "Realtime" {
            Helper.saveBtnTitle(title: "Single Update")
            restartApp()
        }
    }
    
    func restartApp() {
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        
        vc = sb.instantiateViewController(withIdentifier: "mainNav")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Connectivity.isConnectedToInternet() {
            if venus.count == 0 {
                return 1
            } else {
                return venus.count
            }
        } else {
            return 1
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Connectivity.isConnectedToInternet() {
            if venus.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: noDataCellId, for: indexPath) as! NoDataCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: placeCellId, for: indexPath) as! PlaceCell
                cell.placeTitle.text = venus[indexPath.row].name
                cell.placeDesk.text = venus[indexPath.row].address
                VenuRecomService.instance.getPhotosById(id: venus[indexPath.row].id) { (error: Error?, url: String) in
                    let newUrl = "\(url)"
                        Alamofire.request(newUrl).responseImage { (response) in
                                                print(response)
                                                if let image = response.result.value {
                                                    DispatchQueue.main.async {
                                                        cell.placeImg.image = image
                                                    }
                                                }
                                            }

                }
                self.venuId = venus[indexPath.row].id
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: errorCellId, for: indexPath) as! ErrorCell
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if venus.count == 0 {
            return 774
        } else {
            return 115
        }
    }
}

extension MainVC: CLLocationManagerDelegate {
    
    func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if Helper.getBtnTitle() == "Realtime" {
            
            let ll = "\(locValue.latitude),\(locValue.longitude)"
            VenuRecomService.instance.getDataByLoc(location: ll) { (error: Error?, Venues: [VenuModel]?) in
                if let Venues = Venues {
                    self.venus = Venues
                    self.tableView.reloadData()
                }
            }
        } else {
            if startLocation == nil {
                startLocation = locations.first
                let ll = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
                VenuRecomService.instance.getDataByLoc(location: ll) { (error: Error?, Venues: [VenuModel]?) in
                    if let Venues = Venues {
                        self.venus = Venues
                        self.tableView.reloadData()
                    }
                }
            } else if let location = locations.last {
                distance = lastLocation.distance(from: location)
                if distance > 500 {
                    let ll = "\(lastLocation.coordinate.latitude),\(lastLocation.coordinate.longitude)"
                    VenuRecomService.instance.getDataByLoc(location: ll) { (error: Error?, Venues: [VenuModel]?) in
                        if let Venues = Venues {
                            self.venus = Venues
                            self.tableView.reloadData()
                        }
                    }
                    lastLocation = locations.last
                }
            }
            lastLocation = locations.last
        }
    }
}
