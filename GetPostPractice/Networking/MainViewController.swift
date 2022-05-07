//
//  MainViewController.swift
//  Networking
//
//  Created by Андрей  on 07.05.2022.
//  Copyright © 2022 Alexey Efimov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainViewController: UICollectionViewController {

    let actions = ["Download image", "GET", "POST", "Our Courses", "Upload image"]
    
   

    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.lable.text = actions[indexPath.row]
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = actions[indexPath.row]
        
        switch action {
        case "Download image":
            performSegue(withIdentifier: "ShowImage", sender: self)
        case "GET":
            print("GET")
        case "POST":
            print("POST")
        case "Our Courses":
            performSegue(withIdentifier: "OurCourses", sender: self)
        case "Upload image":
            print("Upload image")
        default:
            break
        }
    }

}
