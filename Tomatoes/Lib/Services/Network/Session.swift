//
//  Session.swift
//  Tomatoes
//
//  Created by Paolo Tagliani on 20/10/16.
//  Copyright © 2016 Tomatoes. All rights reserved.
//

import Foundation
import KeychainSwift

class URLSession {
    public var userSessionToken: String? {
        didSet {
            let keychain = KeychainSwift()
            if let token = userSessionToken {
                keychain.set(token, forKey: "es.tomatoe.tomatoes-token")
            }
            else {
                keychain.delete("es.tomatoe.tomatoes-token")
            }
        }
    }
    
    init(){
        let keychain = KeychainSwift()
        self.userSessionToken = keychain.get("es.tomatoe.tomatoes-token")
    }
    
    public var isLogged:Bool {
        return userSessionToken != nil;
    }
    
    public func logout(){
        let keychain = KeychainSwift()
        keychain.delete("es.tomatoe.tomatoes-token")
    }
}
