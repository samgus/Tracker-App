//
//  ViewController.swift
//  Tracker
//
//  Created by Sam Gustafsson on 3/2/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //URL
        let url = URL(string: "https://apis-sandbox.fedex.com/track/v1/trackingnumbers")
        
        guard url != nil else{
            print("Error creating URL object")
            return
        }
        //URL Request
        let request = NSMutableURLRequest(url: NSURL(string: "https://apis-sandbox.fedex.com/track/v1/trackingnumbers")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        //Specify the header
        let headers = [
          "Content-Type": "application/json",
          "X-locale": "en_US",
          "Authorization": "Bearer "
        ]
        
        request.allHTTPHeaderFields = headers
        
        //Spectify the body
        let parameters = [
            
            "includeDetailedScans": true,
            "trackingInfo": [{}] // JSON Payload
        ] as [String : Any]
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            
            request.httpBody = requestBody as Data

        } catch {
            print("Error creating the data object from JSON \(error)")
        }
        
        //Set the request type
        request.httpMethod = "POST"
        
        //Get the URLSession
        let session = URLSession.shared
        
        //Create the data task
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error == nil && data != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
          }
        })
        
        //Fire off the data stack
        dataTask.resume()
        
    }

}

