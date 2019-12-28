//
//  Connectivity.swift
//  NearBy
//
//  Created by Mahmoud Elshakoushy on 12/28/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
