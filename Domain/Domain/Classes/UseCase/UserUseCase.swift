//
//  UserUseCase.swift
//  Domain
//
//  Created by đào sơn on 23/03/2024.
//

import Foundation
import RxSwift

public enum SignState {
    case invalidCredentials
    case duplicatedEmail
    case emptyField
    case success
    case invalidInfor
}

public protocol UserUseCase {
    func validInfo(name: String,
                   email: String,
                   password: String) -> Observable<SignState>
    func signUp(name: String,
                email: String,
                password: String) -> Observable<SignState>
    func signIn(email: String, password: String) -> Observable<(UserEntity?, SignState)>
}
