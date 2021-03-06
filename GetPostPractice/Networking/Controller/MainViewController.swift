//
//  MainViewController.swift
//  Networking
//
//  Created by Андрей  on 07.05.2022.
//  Copyright © 2022 Alexey Efimov. All rights reserved.
//

import UIKit
import UserNotifications

enum Actions: String, CaseIterable {
    
    case downloadImage = "Download image"
    case get = "GET"
    case post = "POST"
    case ourCouses = "Our Courses"
    case uploadImage = "Upload image"
    case downloadFile = "Download file"
    case ourCourcesAlamofire = "Our cources(Alomafire)"
    case responseData = "Response Data"
    case response = "Response"
    case downloadLargeImage = "Download large image"
    case postAlamofire = "Post with Alamofire"
    case putRequest = "Put Request"
    case uploadImageAlamofire = "Upload Image(Alamofire)"
}

private let reuseIdentifier = "Cell"
private let url = "https://jsonplaceholder.typicode.com/posts"
private let swiftBookApi = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
private let uploadImage = "https://api.imgur.com/3/image"


class MainViewController: UICollectionViewController {

    let actions = Actions.allCases
    private var alert: UIAlertController!
    private let dataProvider = DataProvider()
    private var filePath: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotification()
        
        dataProvider.fileLocation = { (location) in
            
            print("Final location is \(location.absoluteString)")
            self.filePath = location.absoluteString
            self.alert.dismiss(animated: false, completion: nil)
            self.postNotification()
        }
    }

    
    func showAlert() {
        
        alert = UIAlertController(title: "Downloading ...", message: "0%", preferredStyle: .alert)
        
        
        let height = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 170)
        alert.view.addConstraint(height)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            
            self.dataProvider.stopDownload()
        }
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true) {
            
            let size = CGSize(width: 40, height: 40)
            let point = CGPoint(x: self.alert.view.frame.width / 2 - size.width / 2, y: self.alert.view.frame.height / 2 - size.height / 2)
            
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: point, size: size))
            activityIndicator.color = .gray
            activityIndicator.startAnimating()
            
            let progressView = UIProgressView(frame: CGRect(x: 0, y: self.alert.view.frame.height - 44, width: self.alert.view.frame.width, height: 2))
            progressView.tintColor = .blue
            
            self.dataProvider.onProgress = { (progress) in
                
                progressView.progress = Float(progress)
                self.alert.message = String(Int(progress * 100)) + "%"
            }
           
            
            self.alert.view.addSubview(activityIndicator)
            self.alert.view.addSubview(progressView)
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell
        guard let myCell = cell else { return UICollectionViewCell()}
        myCell.lable.text = actions[indexPath.row].rawValue
    
        // Configure the cell
    
        return myCell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        
        switch action {
        case .downloadImage:
            performSegue(withIdentifier: "ShowImage", sender: self)
        case .get:
            NetworkManager.getRequest(url: url)
        case .post:
            NetworkManager.postRequest(url: url)
        case .ourCouses:
            performSegue(withIdentifier: "OurCourses", sender: self)
        case .uploadImage:
            NetworkManager.uploadImage(url: uploadImage)
        case .downloadFile:
            showAlert()
            dataProvider.startDownload()
        case .ourCourcesAlamofire:
            performSegue(withIdentifier: "OurCourcesWithAlamofire", sender: self)
        case .responseData:
            performSegue(withIdentifier: "ResponseData", sender: self)
            AlamofireNetworkRequest.responseData(url: swiftBookApi)
        case .response:
            AlamofireNetworkRequest.response(url: swiftBookApi)
        case .downloadLargeImage:
            performSegue(withIdentifier: "ShowProgress", sender: self)
        case .postAlamofire:
            performSegue(withIdentifier: "PostRequest", sender: self)
        case .putRequest:
            performSegue(withIdentifier: "PutRequest", sender: self)
        case .uploadImageAlamofire:
            AlamofireNetworkRequest.uploadImage(url: uploadImage)
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let courceVC = segue.destination as? CoursesViewController
        let imageVC = segue.destination as? ImageViewController
        
        switch segue.identifier {
        case "OurCourses":
            courceVC?.fetchData()
        case "OurCourcesWithAlamofire":
            courceVC?.fetchDataWithAlamofire()
        case "ShowImage":
            imageVC?.fetchImage()
        case "ResponseData":
            imageVC?.fetchDataWithAlamofire()
        case "ShowProgress":
            imageVC?.downloadImageWithProgress()
        case "PostRequest":
            courceVC?.postRequest()
        case "PutRequest":
            courceVC?.putRequest()
        default:
            break
        }
    }
}


extension MainViewController {
    private func registerForNotification() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,
                                                                          .sound]) { (_, _) in
            
        }
    }
    
    
    func postNotification() {
        
        let content = UNMutableNotificationContent()
        
        content.title = "Download completed!"
        content.body = "Your background transfer has completed. File path: \(filePath!)"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "TransferComplete", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
}
