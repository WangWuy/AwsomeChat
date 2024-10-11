//
//  UserUseCase.swift
//  Platform
//
//  Created by đào sơn on 23/03/2024.
//

import Foundation
import Domain
import RxSwift

class UserUseCase: Domain.UserUseCase {
    let userDefaults = UserDefaults.standard

    func validInfo(name: String,
                   email: String,
                   password: String) -> Observable<SignState> {
        let userInfor = UserEntity(name: name, email: email, password: password)
        return Observable.create {[weak self] observer in
            if userInfor.name.isEmpty || userInfor.email.isEmpty || userInfor.password.isEmpty {
                observer.onNext(SignState.emptyField)
            } else if let isValidData = self?.isValidEmail(email: userInfor.email), !isValidData {
                observer.onNext(SignState.invalidInfor)
            } else {
                observer.onNext(SignState.success)
            }

            return Disposables.create()
        }
    }

    func signUp(name: String,
                email: String,
                password: String) -> Observable<SignState> {
        let userInfo = UserEntity(name: name, email: email, password: password)
        return Observable.create { [weak self] observer in
            if self?.userDefaults.value(forKey: userInfo.email) != nil {
                observer.onNext(SignState.duplicatedEmail)
            } else {
                self?.userDefaults.setValue(userInfo.asDictionary(), forKey: userInfo.email)
                observer.onNext(SignState.success)
            }

            return Disposables.create()
        }
    }

    func signIn(email: String, password: String) -> Observable<(Domain.UserEntity?, SignState)> {
        return Observable.create { [weak self] observer in
            if let dict = self?.userDefaults.dictionary(forKey: email) {
                let existedUser = UserEntity(dictionary: dict)
                if existedUser.password == password {
                    observer.onNext((existedUser, SignState.success))
                } else {
                    observer.onNext((nil, SignState.invalidCredentials))
                }
            } else {
                observer.onNext((nil, SignState.invalidCredentials))
            }

            return Disposables.create()
        }
    }

    // MARK: - Helper
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        do {
            let regex = try NSRegularExpression(pattern: emailRegex)
            let nsString = email as NSString
            let results = regex.matches(in: email,
                                        range: NSRange(location: 0, length: nsString.length))

            return !results.isEmpty
        } catch {
            return false
        }
    }

}
