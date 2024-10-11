//
//  MessageUseCase.swift
//  Platform
//
//  Created by đào sơn on 23/03/2024.
//

import Foundation
import Domain

class MessageUseCase: Domain.MessageUseCase {
    func getListMessages() -> [Domain.MessageEntity] {
        return fetchMessageData()
    }

    func fetchMessageData() -> [Domain.MessageEntity] {
        var chatItems: [MessageEntity] = []
        guard let chatFilePath = Bundle.main.path(forResource: "MessageData",
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
                    chatItems.append(MessageEntity(dictionary: dict))
                }
            }

        } catch {
            print("Lỗi khi đọc tệp JSON: \(error.localizedDescription)")
        }

        return chatItems
    }
}
