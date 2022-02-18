//
//  Webservice.swift
//  SearchApp
//
//  Created by Fawad on 17/02/22.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class Webservice
{
    
    func getSchoolData(completion: @escaping(Result<[[String: String]]?, Error>) ->()){
        let url = URL(string: Constants.searchSchoolApiUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  return }
            do{

                
                let dict = try JSONSerialization.jsonObject(with: dataResponse, options: .allowFragments) as? [[String: String]]

                DispatchQueue.main.async {
                    completion(.success(dict))
                }
              
            } catch _ {
                completion(.failure(error!))

           }
        }
        task.resume()
        
    }
    
    func getSchoolsDetailsData(completion: @escaping(Result<[[String: String]]?, Error>) ->()){
        let url = URL(string: Constants.searchSchoolDetailsApiUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  return }
            do{
                let dict = try JSONSerialization.jsonObject(with: dataResponse, options: .allowFragments) as? [[String: String]]
                DispatchQueue.main.async {
                    completion(.success(dict))
                }
              
            } catch _ {
                completion(.failure(error!))

           }
        }
        task.resume()
        
    }
    
}

