//
//  ServiceProvider.swift
//  Tomatoes
//
//  Created by Paolo Tagliani on 29/10/16.
//  Copyright © 2016 Tomatoes. All rights reserved.
//

import Foundation

class ServiceProvider {
    static let sharedInstance = ServiceProvider()
    
    public let networkService = NetworkService()
    
    //Override private init to avoid other call it
    private init () {}
}
