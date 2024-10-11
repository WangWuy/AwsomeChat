//
//  MessageEntity.swift
//  Domain
//
//  Created by đào sơn on 23/03/2024.
//

import UIKit

public protocol MessageEntity {
    var id: String { get }
    var name: String { get }
    var message: String { get }
    var time: String { get }

    init(id: String, name: String, message: String, time: String)
    init(dictionary: NSDictionary)

    func image() -> UIImage?
}
