//
//  ViewController.swift
//  GetPostPractice
//
//  Created by Андрей  on 05.05.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRequest(_ sender: Any) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response,
            let data = data
            else { return }
            print(data)
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch  {
                print(error)
            }
        }.resume()
    }
    @IBAction func postRequest(_ sender: Any) {
    }
    
}

