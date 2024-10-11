//
//  MainNavigator.swift
//  AwesomeChat
//
//  Created by đào sơn on 16/03/2024.
//

import Foundation
import Domain
import Platform

protocol MainNavigatorType {
    mutating func pushToHome(userInfo: UserEntity) -> HomeViewController
    mutating func pushToFriend() -> FriendViewController
    mutating func pushToProfile() -> ProfileViewController
}

struct MainNavigator: MainNavigatorType {
    var homeViewController: HomeViewController?
    var friendViewController: FriendViewController?
    var profileViewController: ProfileViewController?

    mutating func pushToHome(userInfo: UserEntity) -> HomeViewController {
        if let homeViewController = homeViewController {
            return homeViewController
        } else {
            let homeNavigator = HomeNavigator()
            let messageUseCase = UseCaseProvider.getMessageUseCase()
            let homeViewModel = HomeViewModel(navigator: homeNavigator,
                                              userInfo: userInfo,
                                              useCase: messageUseCase)
            let homeVC = HomeViewController(viewModel: homeViewModel)
            homeViewController = homeVC
            return homeVC
        }
    }

    mutating func pushToFriend() -> FriendViewController {
        if let friendViewController = friendViewController {
            return friendViewController
        } else {
            let friendNavigator = FriendNavigator()
            let friendViewModel = FriendViewModel(navigator: friendNavigator)
            let friendVC = FriendViewController(viewModel: friendViewModel)
            friendViewController = friendVC
            return friendVC
        }
    }
    
    mutating func pushToProfile() -> ProfileViewController {
        if let profileViewController = profileViewController {
            return profileViewController
        } else {
            let profileNavigator = ProfileNavigator()
            let profileViewModel = ProfileViewModel(navigator: profileNavigator)
            let profileVC = ProfileViewController(viewModel: profileViewModel)
            profileViewController = profileVC
            return profileVC
        }
    }
    
}
