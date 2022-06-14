//
//  Message.swift
//  WalletSegue
//
//  Created by Jungho Bang on 6/13/22.
//

import Foundation

public struct Message: URLCodable {
    enum Content: Codable {
        case handshake(appId: String, callback: URL)
        case request(Data) // encrypted
        case response(Data) // encrypted
    }
    
    let uuid: UUID
    let sender: PublicKey
    let content: Content
    let version: String
}
