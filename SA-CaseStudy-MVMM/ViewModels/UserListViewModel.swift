//
//  UserListViewModel.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import RxSwift

/// ViewModel that manages the user list screen's business logic
class UserListViewModel {
    /// Published stream of users
    let users = PublishSubject<[User]>()
    /// Loading state of the view
    let isLoading = BehaviorSubject<Bool>(value: false)
    /// Error messages to display
    let errorMessage = PublishSubject<String>()
    
    private let repository: UserRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    /// Coordinator reference for navigation
    var coordinator: AppCoordinator?
    
    /// Initializes the view model with a repository
    /// - Parameter repository: Repository that provides user data
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    /// Loads users from the repository
    func loadUsers() {
        repository.fetchUsers()
            .observe(on: MainScheduler.instance)
            .do(
                onSubscribe: { [weak self] in
                    self?.isLoading.onNext(true)
                },
                onDispose: { [weak self] in
                    self?.isLoading.onNext(false)
                }
            )
            .subscribe(
                onNext: { [weak self] users in
                    self?.users.onNext(users)
                },
                onError: { [weak self] error in
                    self?.errorMessage.onNext("Error: \(error.localizedDescription)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    /// Handles user selection and navigates to detail screen
    /// - Parameter user: Selected user
    func didSelectUser(_ user: User) {
        coordinator?.showUserDetail(user: user)
    }
}
