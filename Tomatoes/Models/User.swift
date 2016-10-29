//
// Created by Paolo Tagliani on 22/10/16.
// Copyright (c) 2016 Tomatoes. All rights reserved.
//

import Foundation
import ObjectMapper

struct User : Mappable {
    public var id: String?
    public var name: String?
    public var email: String?
    public var image: NSURL?
    public var color: String?
    public var volume: Int?
    public var ticking: Bool?
    public var workHourPerDay: Int?
    public var averageHourlyRate: Int?
    public var currency: String?
    public var currencyUnit: String?
    public var providers: [Provider]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        image <- map["image"]
        color <- map["color"]
        volume <- map["volume"]
        ticking <- map["ticking"]
        workHourPerDay <- map["work_hours_per_day"]
        averageHourlyRate <- map["average_hourly_rate"]
        currency <- map["currency"]
        currencyUnit <- map["currency_unit"]
        providers <- map["authorizations"]
    }
}
