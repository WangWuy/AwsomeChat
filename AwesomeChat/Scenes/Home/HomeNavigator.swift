//
//  HomeNavigator.swift
//  AwesomeChat
//
//  Created by đào sơn on 01/03/2024.
//

import Foundation
import Platform
import Domain

protocol HomeNavigatorType {
    func pushToChat(message: MessageEntity) -> ChatViewController
}

struct HomeNavigator: HomeNavigatorType {
    func pushToChat(message: MessageEntity) -> ChatViewController {
        let chatNavigator = ChatNavigator()
        let chatUseCase = UseCaseProvider.getChatUseCase()
        let chatViewModel = ChatViewModel(navigator: chatNavigator,
                                          message: message,
                                          useCase: chatUseCase)
        return ChatViewController(viewModel: chatViewModel)
    }
}
