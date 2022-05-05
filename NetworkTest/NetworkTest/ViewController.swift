//
//  ViewController.swift
//  NetworkTest
//
//  Created by Андрей  on 05.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var getImageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
    }
    
    @IBAction func getImagePressed(_ sender: Any) {
        lable.isHidden = true
        getImageButton.isEnabled = false
        activityIndicator.isHidden = false
        // URL session
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

