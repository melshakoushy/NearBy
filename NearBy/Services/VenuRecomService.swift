//
//  VenuRecomService.swift
//  NearBy
//
//  Created by Mahmoud Elshakoushy on 12/26/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class VenuRecomService {
    
    static let instance = VenuRecomService()
    
    func getDataByLoc(location: String, completion: @escaping (_ error: Error?, _ Venues: [VenuModel]?) -> Void) {
        Alamofire.request("\(VENUES_URL)\(location)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                if let groups = json["response"]["groups"].array {
                    for item in groups {
                        guard let item = item.dictionary else {return}
                        if let items = item["items"]?.array {
                            var venues = [VenuModel]()
                            for item in items {
                                guard let item = item.dictionary else {return}
                                let venu = VenuModel()
                                venu.name = item["venue"]?["name"].string ?? ""
                                venu.address = item["venue"]?["location"]["address"].string ?? ""
                                venu.id = item["venue"]?["id"].string ?? ""
                                
                                venues.append(venu)
                            }
                            
                            completion(nil, venues)
                        }
                    }
                }
            }
        }
    }
    
    func getPhotosById(id: String, completion: @escaping (_ error: Error?, _ imageUrl: String) -> Void) {
        Alamofire.request("\(PHOTOS1_URL)\(id)\(PHOTOS2_URL)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, "")
                print(error)
            case .success(let value):
                let json = JSON(value)
                if let items = json["response"]["photos"]["items"].array {
                    let item = items[0]
                    guard let newItem = item.dictionary else {return}
                    let url = "\(String(describing: newItem["prefix"]?.string ?? ""))500x500\(String(describing: newItem["suffix"]?.string ?? ""))"
                    completion(nil, url)
                }
            }
        }
    }
}

