//
//  NetworkService.swift
//  UserDemoApp
//
//  Created by SaurabhMishra on 08/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation

//MARK: - Netwrok URL Builder
enum URLBuilder{
    static let baseUrl = "https://raw.githubusercontent.com"
    static func buildUrl(for resource: String) -> URL? {
      let urlString = baseUrl + "/\(resource)"
      return URL(string: urlString)
    }
}

//MARK: - Netwrok  Service

class NetworkService{
    
    static let shared = NetworkService()
    private init(){
        
    }

    //MARK: -  API Call
    func getUsers(completionHandler: @escaping ([User]?,Error?)->()) {
        let userUrlStr = "AxxessTech/Mobile-Projects/master/challenge.json"
        guard let url = URLBuilder.buildUrl(for: userUrlStr) else {return}
    
        let urlRequest:URLRequest = URLRequest(url: url)
    
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            
            if let err = err{
                completionHandler(nil,err)
                return
            }
            
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let usersData = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    
                    completionHandler(usersData,nil)
                }
            } catch let error{
                print("Error in decoding\(error)")
            }
            
            
        }.resume()
        
        
    }
    

    
    
}
