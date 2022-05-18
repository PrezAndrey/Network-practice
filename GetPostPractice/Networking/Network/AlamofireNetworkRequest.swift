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
        
        AF.request(url, method: .get).responseJSON { (response) in
            
            print(response)
        }
    }
}
