//
//  MessageEntity.swift
//  Platform
//
//  Created by đào sơn on 23/03/2024.
//

import UIKit
import Domain

struct MessageEntity: Domain.MessageEntity {
    var id: String
    var name: String
    var message: String
    var time: String

    init(id: String, name: String, message: String, time: String) {
        self.id = id
        self.name = name
        self.message = message
        self.time = time
    }

    init(dictionary: NSDictionary) {
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.message = dictionary["message"] as? String ?? ""
        self.time = dictionary["time"] as? String ?? ""
    }

    func image() -> UIImage? {
        return UIImage(named: "ic_avatar_" + id)
    }
}
