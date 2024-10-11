//
//  ChatUseCase.swift
//  AwesomeChat
//
//  Created by đào sơn on 22/03/2024.
//

import Foundation
import Photos

public protocol ChatUseCase {
    func getListChats() -> [ChatEntity]
    func addNewItem(content: String,
                    isSender: Bool,
                    time: String,
                    asset: PHAsset?)
}
