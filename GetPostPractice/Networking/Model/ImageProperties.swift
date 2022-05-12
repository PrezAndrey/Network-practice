//
//  ImageProperties.swift
//  Networking
//
//  Created by Андрей  on 12.05.2022.
//  Copyright © 2022 Alexey Efimov. All rights reserved.
//

import UIKit

struct ImageProperties {
    
    let key: String
    let data: Data
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        guard let data = image.pngData() else { return nil }
        self.data = data
    }
}
