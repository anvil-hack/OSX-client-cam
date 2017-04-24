//
//  Service.swift
//  OSX-client-cam
//
//  Created by Remi Robert on 22/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Cocoa
import Alamofire

class APIService {

    static let shared = APIService()

    func upload(path: String) {
        guard let url = URL(string: "\(baseUrl)/capture") else {return}
        Alamofire.request(url, method: HTTPMethod.post, parameters: ["path": path]).response { response in
            debugPrint(response)
        }
    }
}
