//
//  ApplicationNavigator.swift
//  AwesomeChat
//
//  Created by đào sơn on 01/03/2024.
//

import UIKit
import Platform

protocol ApplicationNavigatorType {
    func configMainInterface() -> UINavigationController
}

struct ApplicationNavigator: ApplicationNavigatorType {
    func configMainInterface() -> UINavigationController {
        let navigator = SignInNavigator()
        let userUseCase = UseCaseProvider.getUserUseCase()
        let viewModel = SignInViewModel(navigator: navigator, useCase: userUseCase)
        let signInViewController = SignInViewController(viewModel: viewModel)
        let rootViewController = UINavigationController(rootViewController: signInViewController)
        rootViewController.navigationBar.isHidden = true
        return rootViewController
    }
}
