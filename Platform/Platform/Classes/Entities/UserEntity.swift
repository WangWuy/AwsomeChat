//
//  UserEntity.swift
//  Platform
//
//  Created by đào sơn on 23/03/2024.
//

import Foundation
import Domain

struct UserEntity: Domain.UserEntity {
    var name: String
    var email: String
    var password: String

    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }

    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
    }

    func asDictionary() -> [String: Any] {
        return ["name": name, "email": email, "password": password]
    }
}
