//
//  ChatEntity.swift
//  AwesomeChat
//
//  Created by đào sơn on 22/03/2024.
//

import Foundation
import Photos

public protocol ChatEntity {
    var content: String { get }
    var isSender: Bool { get }
    var time: String { get }
    var asset: PHAsset? { get }

    init(dict: NSDictionary)

    init(content: String, isSender: Bool, time: String, asset: PHAsset?)
}
