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
        // URL
        guard let url = URL(string: "https://avatars.mds.yandex.net/get-zen_doc/3397137/pub_5fdf524027ce98245abbb9e2_5fdf933cf5a6f429fcf0abcd/scale_1200") else { return }
        
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

