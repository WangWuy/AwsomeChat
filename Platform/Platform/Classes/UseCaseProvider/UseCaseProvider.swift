//
//  UseCaseProvider.swift
//  AwesomeChat
//
//  Created by đào sơn on 22/03/2024.
//

import Foundation
import Domain

public class UseCaseProvider {
    public static func getChatUseCase() -> Domain.ChatUseCase {
        return ChatUseCase()
    }

    public static func getUserUseCase() -> Domain.UserUseCase {
        return UserUseCase()
    }

    public static func getMessageUseCase() -> Domain.MessageUseCase {
        return MessageUseCase()
    }
}
