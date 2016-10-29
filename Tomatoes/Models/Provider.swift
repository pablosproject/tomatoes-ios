//
//  Provider.swift
//  Tomatoes
//
//  Created by Paolo Tagliani on 24/10/16.
//  Copyright © 2016 Tomatoes. All rights reserved.
//

import Foundation
import ObjectMapper

struct Provider : Mappable {
    public var providerName:String?
    public var uid:String?
    public var nickname:String?
    public var image:NSURL?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        providerName <- map["provider"]
        uid <- map["uid"]
        nickname <- map["nickname"]
        image <- map["email"]
    }
}
