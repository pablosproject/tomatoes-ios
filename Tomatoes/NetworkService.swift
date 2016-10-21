//
//  NetworkService.swift
//  Tomatoes
//
//  Created by Paolo Tagliani on 20/10/16.
//  Copyright © 2016 Tomatoes. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    internal let baseURL:String = "http://www.tomato.es/api/"
    internal let githubURL:String = "https://api.github.com/authorizations"
    
    private var currentSession = URLSession()
    
    enum APIEndpoint: String {
        case User = "item/"
        case Session = "session/"
    }
    
    public func isLogged () -> Bool {
        return currentSession.isLogged
    }
    
    //TODO: pass error
    public func login(username:String!, password:String!, completion:@escaping (_:Bool) -> Void) {
        let openSession:(_ githubToken:String, _ completion: (_:(Bool) -> Void)) -> Void  = { githubToken, completion in
            let parameters  = ["provider" : "github", "access_token" : githubToken]
            let path = self.baseURL+APIEndpoint.Session.rawValue
            Alamofire.request(path, method: .post, parameters: parameters, encoding:JSONEncoding.default).validate().responseJSON{ response in
                switch response.result {
                case .success :
                    guard let JSON = response.result.value as? NSDictionary , let token = JSON["token"] as? String else {
                        completion(false)
                        return
                    }
                    //Save received token for future session
                    self.currentSession.userSessionToken = token
                    completion(true)
                case .failure(let error) :
                    print(error)
                    completion(true)
                }
            }
        }
    
        //Create request for github
        var headers: HTTPHeaders = [:]
        if let authorizationHeader = Request.authorizationHeader(user: username, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        let parameters = ["client_id" : "bc037a4baea81c17986e",
                          "client_secret" : "9232ddcd1ddf090a635d7b07679078ebed29fa82",
                          "note" : "Tomatoes token"]
        
        Alamofire.request(githubURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success :
                guard let JSON = response.result.value as? NSDictionary, let token = JSON["token"] as? String else {
                    completion(false)
                    return
                }
                openSession(token, completion)
            case .failure(let error) :
                print(error)
                completion(true)
            }
        }
    }
    
    public func user(){
        
    }
}
