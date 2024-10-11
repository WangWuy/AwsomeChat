//
//  SignInViewModel.swift
//  AwesomeChat
//
//  Created by đào sơn on 01/03/2024.
//

import Foundation
import RxSwift
import Domain

class SignInViewModel {
    var navigator: SignInNavigatorType
    var useCase: UserUseCase

    init(navigator: SignInNavigatorType, useCase: UserUseCase) {
        self.navigator = navigator
        self.useCase = useCase
    }
}

extension SignInViewModel: ViewModelType {
    struct Input {
        let didTapSignIn: Observable<(String?, String?)>
        let didChangeInfor: Observable<(String?, String?)>
        let didTapSignUp: Observable<Void>
    }

    struct Output {
        let pushToHome: Observable<UIViewController?>
        let changeInforStatus: Observable<Bool>
        let pushToSignUp: Observable<SignUpViewController?>
    }
}

extension SignInViewModel {
    func transform(_ input: Input) -> Output {
        // MARK: - remove weak self
        let useCase = self.useCase
        let pushToHome: Observable<UIViewController?> = input.didTapSignIn
            .flatMap { [weak self] (email, password) in
                useCase.signIn(email: email ?? "", password: password ?? "")
                    .map { (userInfo, signState) in
                        if let userInfo = userInfo {
                            print("Sign in successfully with user \(userInfo.name)")
                            return self?.navigator.pushToMain(userInfo: userInfo)
                        } else {
                            return self?.navigator.presentAlert(signState: signState)
                        }

                    }
            }

        let changeInforStatus = input.didChangeInfor
            .map { (email, password) -> Bool in
                guard let email = email, let password = password else {
                    return false
                }

                return !email.isEmpty && !password.isEmpty
            }

        let pushToSignUp: Observable<SignUpViewController?> = input.didTapSignUp
            .map { [weak self] in
                guard let self = self else { return nil }
                return self.navigator.pushToSignUp(useCase: self.useCase)
            }

        return .init(pushToHome: pushToHome, 
                     changeInforStatus: changeInforStatus,
                     pushToSignUp: pushToSignUp)
    }
}
