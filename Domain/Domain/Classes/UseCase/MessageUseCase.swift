//
//  MessageUseCase.swift
//  Domain
//
//  Created by đào sơn on 23/03/2024.
//

import Foundation

public protocol MessageUseCase {
    func getListMessages() -> [MessageEntity]
}
