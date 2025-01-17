//
//  AppCoordinator.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 18.01.2025.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        // Global navigation bar ayarları
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        navigationController.navigationBar.tintColor = .black // Back button rengi
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func start() {
        showUserList()
    }
    
    private func showUserList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController else {
            print("Failed to instantiate UserListViewController")
            return
        }
        
        let viewModel = UserListViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showUserDetail(user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else {
            print("Failed to instantiate UserDetailViewController") // Debug için
            return
        }
        let viewModel = UserDetailViewModel(user: user)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
