//
//  ChatViewModel.swift
//  AwesomeChat
//
//  Created by đào sơn on 07/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
import Photos
import Domain

class ChatViewModel {
    var navigator: ChatNavigatorType
    var useCase: ChatUseCase
    var message: MessageEntity
    var disposeBag = DisposeBag()

    init(navigator: ChatNavigatorType, message: MessageEntity, useCase: ChatUseCase) {
        self.navigator = navigator
        self.message = message
        self.useCase = useCase
    }

    func getHeightForRow(at index: Int) -> CGFloat {
        let listChatItems = useCase.getListChats()
        if listChatItems[index].asset != nil {
            return 160.0
        } else {
            let cellWidth = UIScreen.main.bounds.width * 285.0 / 375.0 - 30.0
            let content = listChatItems[index].content
            let font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            let attributes: [NSAttributedString.Key: Any] = [.font: font]
            let size = (content.trimmingCharacters(in: .whitespacesAndNewlines) as NSString)
                .size(withAttributes: attributes)
            let numberOfLines = Int(ceil(size.width / cellWidth))
            let cellHeight = Double(numberOfLines) * 24.0 + 70.0
            return CGFloat(cellHeight)
        }
    }
}

extension ChatViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: Observable<Void>
        let didTapChatMessage: Observable<(String, [PHAsset])>
        let didTapChatImage: Observable<[PHAsset]>
        let didTapAddMedia: Observable<Bool>
        let selectedPHassets: BehaviorRelay<[PHAsset]>
    }

    struct Output {
        let bindMessageData: Observable<MessageEntity>
        let bindTableData: Observable<[ChatEntity]>
        let didSentMessage: Observable<[ChatEntity]>
        let showImagePicker: Observable<ImagePickerNavigator?>
        let message: MessageEntity
    }

    func transform(_ input: Input) -> Output {
        let message = message
        let listChatItems = useCase.getListChats()
        let navigator = navigator

        let bindMessageData = input.viewWillAppear
            .map {
                return message
            }

        let bindTableData = input.viewWillAppear
            .map {
                return listChatItems
            }

        let didSentMessage: Observable<[ChatEntity]> = input.didTapChatMessage
            .map { [weak self] message, selectedAssets in
                guard let self = self else {
                    return []
                }

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"

                if !message.isEmpty {
                    self.useCase.addNewItem(content: message,
                                            isSender: true,
                                            time: dateFormatter.string(from: Date()),
                                            asset: nil)
                }

                selectedAssets.forEach { asset in
                    self.useCase.addNewItem(content: message,
                                            isSender: true,
                                            time: dateFormatter.string(from: Date()),
                                            asset: asset)
                }

                return self.useCase.getListChats()
            }

        let showImagePicker: Observable<ImagePickerNavigator?> = input.didTapAddMedia
            .map { isShowingImagePicker in
                if !isShowingImagePicker {
                    let imgPickerNavigator = ImagePickerNavigator()
                    imgPickerNavigator.input.onNext(.init(mediaType: .just(.video)))
                    return imgPickerNavigator
                } else {
                    return nil
                }
            }

        return .init(bindMessageData: bindMessageData,
                     bindTableData: bindTableData,
                     didSentMessage: didSentMessage,
                     showImagePicker: showImagePicker,
                     message: message)
    }
}
