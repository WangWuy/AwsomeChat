//
//  SignInNavigator.swift
//  AwesomeChat
//
//  Created by đào sơn on 01/03/2024.
//

import UIKit
import Domain
import Platform

protocol SignInNavigatorType {
    func pushToSignUp(useCase: UserUseCase) -> SignUpViewController
    func presentAlert(signState: SignState) -> UIAlertController
    func pushToMain(userInfo: UserEntity) -> MainViewController
}

struct SignInNavigator: SignInNavigatorType {
    func pushToSignUp(useCase: UserUseCase) -> SignUpViewController {
        let signUpNavigator = SignUpNavigator()
        let signUpViewModel = SignUpViewModel(navigator: signUpNavigator,
                                              useCase: useCase)
        return SignUpViewController(viewModel: signUpViewModel)
    }

    func presentAlert(signState: SignState) -> UIAlertController {
        var title = ""
        var message = ""
        switch signState {
        case .invalidInfor:
            title = "Failed to sign in"
            message = "This email was not valid. Try another one!"
        case .emptyField:
            title = "Failed to sign in"
            message = "Fields must not be empty!"
        case .invalidCredentials:
            title = "Failed to sign in"
            message = "Your email or password is incorrect. Please try again!"
        default:
            break
        }

        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertVC.addAction(okAction)
        return alertVC
    }

    func pushToMain(userInfo: UserEntity) -> MainViewController {
        let mainNavigator = MainNavigator()
        let mainViewModel = MainViewModel(navigator: mainNavigator,
                                          userInfo: userInfo)
        return MainViewController(viewModel: mainViewModel)
    }
}
