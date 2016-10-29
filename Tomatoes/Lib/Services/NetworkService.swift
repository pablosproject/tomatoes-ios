//
//  NetworkService.swift
//  Tomatoes
//
//  Created by Paolo Tagliani on 20/10/16.
//  Copyright © 2016 Tomatoes. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


enum Router: URLRequestConvertible {
    case createSession(parameters:Parameters)
    case getUser(parameters:Parameters)
    case updateUser(username: String, parameters: Parameters)
    
    static let APIbaseURL:String = "http://www.tomato.es/api/"
    static let githubURL:String = "https://api.github.com/authorizations"
    
    var method: HTTPMethod {
        switch self {
        case .createSession:
            return .post
        case .getUser:
            return .get
        case .updateUser:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .createSession:
            return "session"
        case .getUser:
            return "user"
        case .updateUser:
            return "user"
        }
    }
    
    var baseURL : String {
        switch self {
        case .createSession:
            return Router.APIbaseURL
        case .getUser:
            return Router.APIbaseURL
        case .updateUser:
            return Router.APIbaseURL
        }
    }
    
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try self.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .createSession(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .getUser(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .updateUser(_, let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}

class NetworkService {
    
    private var currentSession = URLSession()

    //MARK: login management
    public func isLogged () -> Bool {
        return currentSession.isLogged
    }

    public func logout () {
        currentSession.logout()
    }

    //MARK: API management
    //TODO: pass error
    public func login(username:String!, password:String!, completion:@escaping (_:Bool) -> Void) {
        let openSession:(_ githubToken:String, _ completion: (_:(Bool) -> Void)) -> Void  = { githubToken, completion in
            let parameters  = ["provider" : "github", "access_token" : githubToken]
            Alamofire.request(Router.createSession(parameters: parameters)).validate().responseJSON{ response in
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
        
        Alamofire.request(Router.githubURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
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
        let parameters  = self.tokenParameter()
        Alamofire.request(Router.getUser(parameters: parameters)).validate().responseObject{(response: DataResponse<User>) in
            switch response.result {
            case .success :
                let user = response.result.value
                print (user)
            case .failure(let error) :
                print(error)
                //TODO
            }
        }
    }
    
    public func createTomato(tagList:[String]!) {
        var parameters = self.tokenParameter()
        let tagString = tagList.joined(separator: ",")
        parameters["tomato"] = ["tag_list" : tagString]
        Alamofire.request(Router.getUser(parameters: parameters)).validate().responseObject{(response: DataResponse<User>) in
            let user = response.result.value
            print (user)
        }
    }
    
    //MARK Private session
    private func tokenParameter() -> Parameters {
        var parameters : Parameters = [:]
        if let token = currentSession.userSessionToken {
            parameters["token"] = token
        }
        return parameters
    }
}
