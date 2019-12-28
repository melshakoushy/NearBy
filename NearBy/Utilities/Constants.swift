//
//  Constants.swift
//  NearBy
//
//  Created by Mahmoud Elshakoushy on 12/24/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation

//API Details
let CLIENT_ID = "DZSWCHRM53J5SC3FINASIV0KKGO511OR1CAQESW4CMHCWWVB"
let CLIENT_SECRET = "3IRXW0GAXIPTQD3OCOXROBU4GAL4E4RHX30GP5QLYHTOGMBM"
let V = "20191224"

//URLS
let VENUES_URL  = "https://api.foursquare.com/v2/venues/explore?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=\(V)&ll="
let PHOTOS1_URL = "https://api.foursquare.com/v2/venues/"
let PHOTOS2_URL = "/photos?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=\(V)&group=venue&limit=5"

//Headers
let HEADER = [
    "Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"
]
