//
//  HomeViewModel.swift
//  AwesomeChat
//
//  Created by đào sơn on 01/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

class HomeViewModel {
    var navigator: HomeNavigatorType
    var useCase: MessageUseCase
    var userInfo: UserEntity
    var listMessages: [MessageEntity] = []

    init(navigator: HomeNavigatorType,
         userInfo: UserEntity,
         useCase: MessageUseCase) {
        self.userInfo = userInfo
        self.navigator = navigator
        self.useCase = useCase
        createMessages()
    }

    func createMessages() {
        self.listMessages = useCase.getListMessages()
    }
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: Observable<Void>
        let didTapCell: Observable<Int>
    }

    struct Output {
        let bindTableData: Observable<[MessageEntity]>
        let pushToChat: Observable<ChatViewController>
    }

    func transform(_ input: Input) -> Output {
        let listMessages = self.listMessages
        let navigator = self.navigator
        let bindTableData: Observable<[MessageEntity]> = input.viewWillAppear
            .map {
                return listMessages
            }

        let pushToChat = input.didTapCell
            .map { index in
                return navigator.pushToChat(message: listMessages[index])
            }

        return .init(bindTableData: bindTableData, pushToChat: pushToChat)
    }
}
