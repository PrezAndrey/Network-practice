//
//  MainViewController.swift
//  Networking
//
//  Created by Андрей  on 07.05.2022.
//  Copyright © 2022 Alexey Efimov. All rights reserved.
//

import UIKit


enum Actions: String, CaseIterable {
    
    case downloadImage = "Download image"
    case get = "GET"
    case post = "POST"
    case ourCouses = "Our Courses"
    case uploadImage = "Upload image"
    
}

private let reuseIdentifier = "Cell"

private let url = "https://jsonplaceholder.typicode.com/posts"

class MainViewController: UICollectionViewController {

    let actions = Actions.allCases
    
   

    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.lable.text = actions[indexPath.row].rawValue
    
        // Configure the cell
    
        return cell
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
            print("Upload image")
        }
    }

}
