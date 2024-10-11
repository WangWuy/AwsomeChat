//
//  ChatUseCaseImpl.swift
//  AwesomeChat
//
//  Created by đào sơn on 22/03/2024.
//

import Foundation
import Photos
import Domain

class ChatUseCase: Domain.ChatUseCase {
    var listChatItems: [ChatEntity] = []

    func getListChats() -> [Domain.ChatEntity] {
        if listChatItems.isEmpty {
            let chatItems = self.fetchChatData()
            listChatItems = chatItems
            return chatItems
        } else {
            return listChatItems
        }
    }

    func addNewItem(content: String,
                    isSender: Bool,
                    time: String,
                    asset: PHAsset?) {
        let chatItem = ChatEntity(content: content,
                                      isSender: isSender,
                                      time: time,
                                      asset: asset)
        listChatItems.append(chatItem)
    }

    func fetchChatData() -> [ChatEntity] {
        var chatItems: [ChatEntity] = []
        guard let chatFilePath = Bundle.main.path(forResource: "ChatData",
                                                  ofType: "json") else {
            return []
        }

        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: chatFilePath))
            guard let dataDict = try JSONSerialization
                .jsonObject(with: jsonData, options: []) as? NSDictionary else {
                return []
            }

            guard let dataArr = dataDict.value(forKey: "data") as? NSArray else {
                return []
            }

            dataArr.forEach {
                if let dict = $0 as? NSDictionary {
                    chatItems.append(ChatEntity(dict: dict))
                }
            }

        } catch {
            print("Lỗi khi đọc tệp JSON: \(error.localizedDescription)")
        }

        return chatItems
    }
}
