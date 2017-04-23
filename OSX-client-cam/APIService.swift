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

    func upload(data: Data, completion: @escaping (Bool) -> Void) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data.base64EncodedData(), withName: "file")
        },
            to: "\(baseUrl)/capture",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(_, _, _):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
        }
        )
    }
}
