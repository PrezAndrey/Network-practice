//
//  AlamofireNetworkRequest.swift
//  Networking
//
//  Created by Андрей  on 18.05.2022.
//  Copyright © 2022 Alexey Efimov. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class AlamofireNetworkRequest {
    static var onProgress: ((Double) -> ())?
    static var completed: ((String) -> ())?
    
    static func sendRequest(url: String, completion: @escaping ([Course]) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                var cources = [Course]()
                cources = Course.getArray(from: value)!
                completion(cources)
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url).responseData { (responseData) in
            
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responseData(url: String) {
        AF.request(url).responseData { (responseData) in
            
            switch responseData.result {
            case .success(let data):
                guard let string = String(data: data, encoding: .utf8) else { return }
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func response(url: String) {
        
        AF.request(url).response { (response) in
            
            guard let data = response.data,
                  let string = String(data: data, encoding: .utf8) else { return }
            
            print(string)
        }
    }
    
    
    static func downloadImageWithProgress(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        
        AF.request(url).validate().downloadProgress { (progress) in
    
            print("totalUnitCount: \(progress.totalUnitCount)")
            print("completedUnitCount: \(progress.completedUnitCount)")
            print("fractionCompleted: \(progress.fractionCompleted)")
            print("localazedDescription: \(progress.localizedDescription!)")
            print("---------------------------------------------------------------")
            
            self.onProgress?(progress.fractionCompleted)
            self.completed?(progress.localizedDescription)
        }.response { (responseData) in
            
            guard let data = responseData.data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    
    static func postRequest(url: String, completion: @escaping (_ cources: [Course]) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [String: Any] = ["name": "Nerwork Request",
                                       "link": "https://swiftbook.ru/contents/our-first-applications/",
                                       "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2020/03/12-course-copy-16.jpg",
                                       "numberOfLessons": "18",
                                       "numberOfTests": "10"]
        
        AF.request(url, method: .post, parameters: userData).responseJSON{ (responseJSON) in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            print("Status code: \(statusCode)")
            
            switch responseJSON.result {
            case .success(let value):
                print(value)
                guard let jsonObject = value as? [String: Any],
                      let cource = Course(json: jsonObject) else { return }
                
                var cources = [Course]()
                cources.append(cource)
                
                completion(cources)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    static func putRequest(url: String, completion: @escaping (_ cources: [Course]) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [String: Any] = ["name": "Nerwork Request with Alamofire",
                                       "link": "https://swiftbook.ru/contents/our-first-applications/",
                                       "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2020/03/12-course-copy-16.jpg",
                                       "numberOfLessons": 18,
                                       "numberOfTests": 10]
        
        AF.request(url, method: .put, parameters: userData).responseJSON{ (responseJSON) in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            print("Status code: \(statusCode)")
            
            switch responseJSON.result {
            case .success(let value):
                print(value)
                guard let jsonObject = value as? [String: Any],
                      let cource = Course(json: jsonObject) else { return }
                
                var cources = [Course]()
                cources.append(cource)
                
                completion(cources)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    static func uploadImage(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let image = UIImage(named: "naruto")!
        let data = image.pngData()!
        
        let httpHeaders: HTTPHeaders = ["Authorization": "Client-ID 0d60631c824bd17"]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data, withName: "image")
        }, to: url, headers: httpHeaders) { (encodingCompletion) in
            
//            switch encodingCompletion {
//                case .success(request: let uploadRequest, streamingFromDisk: let streamingFromDisk, streamFileURL: let streamFileURL):
//                    print(uploadRequest)
//                    print(streamFileURL)
//                    print(streamingFromDisk)
//                case .failure(let error):
//                    print(error)
//            }
            
        }
    }
}
