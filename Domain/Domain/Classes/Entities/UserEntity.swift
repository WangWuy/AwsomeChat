//
//  UserEntity.swift
//  Domain
//
//  Created by đào sơn on 23/03/2024.
//

import Foundation

public protocol UserEntity {
    var name: String { get }
    var email: String { get }
    var password: String { get }

    init(name: String, email: String, password: String)
    init(dictionary: [String: Any])
    func asDictionary() -> [String: Any]
}
