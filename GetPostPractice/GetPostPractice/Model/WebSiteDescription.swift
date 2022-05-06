//
//  WebSiteDescription.swift
//  GetPostPractice
//
//  Created by Андрей  on 06.05.2022.
//

import Foundation

struct WebSiteDescription: Decodable {
    
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
