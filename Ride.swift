//
//  Ride.swift
//  CARGo
//
//  Created by Vaishak iyer on 03/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import Foundation

class Ride {
    let id: Int
    let location: String
    let pickupLocation: String
    let time: String
    init (id: Int, location: String, pickupLocation: String, time: String) {
        self.id = id
        self.location = location
        self.pickupLocation = pickupLocation
        self.time = time
    }
}
