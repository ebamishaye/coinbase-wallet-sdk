//
//  KeyManager.swift
//  WalletSegue
//
//  Created by Jungho Bang on 6/9/22.
//

import Foundation
import CryptoKit

public typealias PrivateKey = Curve25519.KeyAgreement.PrivateKey
public typealias PublicKey = Curve25519.KeyAgreement.PublicKey

class KeyManager {
    let privateKey = PrivateKey()
    
    var publicKey: PublicKey {
        return privateKey.publicKey
    }
    
    var peerPublicKey: PublicKey?
    
    func deriveSymmetricKey(
        with ownPrivateKey: PrivateKey,
        _ peerPublicKey: PublicKey
    ) -> SymmetricKey {
        let sharedSecret = try! ownPrivateKey.sharedSecretFromKeyAgreement(with: peerPublicKey)
        return sharedSecret.hkdfDerivedSymmetricKey(
            using: SHA256.self,
            salt: Data(),
            sharedInfo: Data(),
            outputByteCount: 32
        )
    }
}
