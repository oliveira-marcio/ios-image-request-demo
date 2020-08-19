//
//  ViewController.swift
//  ImageRequestDemo
//
//  Created by Márcio Oliveira on 8/19/20.
//  Copyright © 2020 Márcio Oliveira. All rights reserved.
//

import UIKit

enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var loadImageButton: UIButton!
    @IBOutlet weak var networkImageView: UIImageView!
    
    let imageLocation = KittenImageLocation.http.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func handleLoadImageButtonPress(_ sender: Any) {
        guard let imageUrl = URL(string: imageLocation) else {
            print("Error creating image URL.")
            return
        }
        /*
        let task = URLSession.shared.dataTask(with: imageUrl) {
            (data, response, error) in
            guard let data = data else {
                print("No data returned or there was an error.")
                return
            }
            
            let downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.networkImageView.image = downloadedImage
            }
        }
        */
        let task = URLSession.shared.downloadTask(with: imageUrl) {
            (location, response, error) in
            guard let location = location else {
                print("Location is nil")
                return
            }
            
            print(location)
            
            let imageData = try! Data(contentsOf: imageUrl)
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.networkImageView.image = image 
            }
        }
        
        task.resume()
    }
}

