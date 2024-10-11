//
//  SignUpViewModel.swift
//  AwesomeChat
//
//  Created by đào sơn on 02/03/2024.
//

import Foundation
import RxSwift
import Domain

class SignUpViewModel {
    var navigator: SignUpNavigatorType
    var useCase: UserUseCase

    init(navigator: SignUpNavigatorType, useCase: UserUseCase) {
        self.navigator = navigator
        self.useCase = useCase
    }
}

extension SignUpViewModel: ViewModelType {
    struct Input {
        let didChangeInfor: Observable<(String?, String?, String?)>
        let didTapSignUp: Observable<(String?, String?, String?)>
    }

    struct Output {
        let changeInforStatus: Observable<SignState>
        let presentAlert: Observable<UIAlertController>
    }
}

extension SignUpViewModel {
    func transform(_ input: Input) -> Output {
        let useCase = self.useCase
        let changeInforStatus = input.didChangeInfor
            .flatMap { (name, email, password)  in
                guard let name = name, let email = email, let password = password else {
                    return Observable.just(SignState.emptyField)
                }

                return useCase.validInfo(name: name,
                                         email: email,
                                         password: password)
            }

        let presentAlert = input.didTapSignUp
            .flatMap { (name, email, password) in
                guard let name = name, let email = email, let password = password else {
                    return Observable.just(UIAlertController())
                }

                return useCase.signUp(name: name,
                                      email: email,
                                      password: password)
                    .map { [weak self] signState in
                        guard let self = self else {
                            return UIAlertController()
                        }
                        return self.navigator.presentAlert(signState: signState)
                }
            }
        return .init(changeInforStatus: changeInforStatus,
                     presentAlert: presentAlert)
    }
}
