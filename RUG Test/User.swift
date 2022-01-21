//
//  User.swift
//  User
//
//  Created by Jack on 1/19/22.
//

import Foundation
import UIKit


class User {
    var first : String
    var last : String
    var image : UIImage?
    
    init(first: String, last: String, image: UIImage? = nil) {
        self.first = first
        self.last = last
        self.image = image
    }
}
