//
//  Helper.swift
//  NearBy
//
//  Created by Mahmoud Elshakoushy on 12/26/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation

class Helper: NSObject {
    
    class func saveBtnTitle(title: String) {
        let def = UserDefaults.standard
        def.setValue(title, forKey: "title")
        def.synchronize()
    }
    
    class func getBtnTitle() -> String! {
        let def = UserDefaults.standard
        return def.object(forKey: "title") as? String
    }
}
