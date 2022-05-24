//
//  ImageViewController.swift
//  Networking
//
//  Created by Alexey Efimov on 27.07.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit
import Alamofire

class ImageViewController: UIViewController {
    
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let largeImageUrl = "https://mobimg.b-cdn.net/v3/fetch/57/57ae20afa438e15c9c86d1ebbdf5c504.jpeg"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var completedLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    func fetchImage() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.downloadImage(url: url) { image in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func fetchDataWithAlamofire() {
        
        AlamofireNetworkRequest.downloadImage(url: url) { image in
            
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func downloadImageWithProgress() {
        
        AlamofireNetworkRequest.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
        
        AlamofireNetworkRequest.completed = { completed in
            self.completedLable.isHidden = false
            self.completedLable.text = completed
            
        }
        
        AlamofireNetworkRequest.downloadImageWithProgress(url: largeImageUrl) { (image) in
            
            self.activityIndicator.stopAnimating()
            self.completedLable.isHidden = true
            self.progressView.isHidden = true
            self.imageView.image = image
        }
    }
    
}
