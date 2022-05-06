//
//  ImageViewController.swift
//  GetPostPractice
//
//  Created by Андрей  on 05.05.2022.
//

import Foundation
import UIKit

class ImageViewController: ViewController {
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        fetchImage()
        
    }
    
    func fetchImage() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        
        guard let url = URL(string: "https://kartinkin.net/uploads/posts/2021-07/1627121281_31-kartinkin-com-p-gats-v-brone-berserka-art-art-krasivo-35.jpg") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, respionse, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    
    
    
    
}
