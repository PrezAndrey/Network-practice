//
//  AlamofireNetworkRequest.swift
//  Networking
//
//  Created by Андрей  on 18.05.2022.
//  Copyright © 2022 Alexey Efimov. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static func sendRequest(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
            
//            guard let statusCode = response.response?.statusCode else { return }
            
//            print("Status code:", statusCode)
//
//
//            if (200..<300).contains(statusCode) {
//                let value = response.value
//                print("Value", value ?? nil)
//            } else {
//                let error = response.error
//                print(error ?? "Error")
//            }
        }
    }
}
