//
//  Person.swift
//  Remember Names
//
//  Created by Mohsin khan on 06/11/2025.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Person{
    var id = UUID()
    var name : String
    @Attribute(.externalStorage) var photo : Data
    var latitude: Double?
    var longitude: Double?

    init(id: UUID = UUID(), name: String, photo: Data, latitude: Double? = nil, longitude: Double? = nil) {
        self.id = id
        self.name = name
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
}
