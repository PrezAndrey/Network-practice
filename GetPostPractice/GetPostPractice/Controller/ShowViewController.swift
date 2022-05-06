//
//  ShowViewController.swift
//  GetPostPractice
//
//  Created by Андрей  on 06.05.2022.
//

import Foundation
import UIKit

class ShowViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_course"
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_courses"
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_website_description"
        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_missing_or_wrong_fields"
       
        guard let url = URL(string: jsonUrlString) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let courses = try JSONDecoder().decode(WebSiteDescription.self, from: data)
                print("\(courses.courses)")
            } catch let error {
                print("Error serialization JSON", error)
            }
        }.resume()
    }
    
    
    
}
