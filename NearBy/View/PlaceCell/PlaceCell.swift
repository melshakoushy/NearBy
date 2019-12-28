//
//  PlaceCell.swift
//  NearBy
//
//  Created by Mahmoud Elshakoushy on 12/24/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var placeImg: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeDesk: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 10
        bgView.layer.borderColor = #colorLiteral(red: 0.1217509285, green: 0.576944828, blue: 0.08966673166, alpha: 1)
        bgView.layer.borderWidth = 1
    }
}
