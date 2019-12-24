//
//  ViewController.swift
//  NearBy
//
//  Created by Mahmoud Elshakoushy on 12/24/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class SingleUpdateVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Constants
    let placeCellId = "PlaceCell"
    let noDataCellId = "NoDataCell"
    let errorCellId = "ErrorCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: placeCellId, bundle: nil), forCellReuseIdentifier: placeCellId)
        tableView.register(UINib(nibName: noDataCellId, bundle: nil), forCellReuseIdentifier: noDataCellId)
        tableView.register(UINib(nibName: errorCellId, bundle: nil), forCellReuseIdentifier: errorCellId)
    }
    
    @IBAction func realtimeBtnPressed(_ sender: Any) {
    }
    
}

extension SingleUpdateVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: placeCellId, for: indexPath) as! PlaceCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}

