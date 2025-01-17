//
//  UserListViewModel.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import RxSwift

class UserListViewModel {
    var coordinator: AppCoordinator?
    private let disposeBag = DisposeBag()
    private let repository: UserRepositoryProtocol
    
    let users = PublishSubject<[User]>()
    let errorMessage = PublishSubject<String>()
    let isLoading = PublishSubject<Bool>()
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func loadUsers() {
        isLoading.onNext(true)
        repository.fetchUsers()
            .subscribe(
                onNext: { [weak self] users in
                    self?.isLoading.onNext(false)
                    self?.users.onNext(users)
                },
                onError: { [weak self] error in
                    self?.isLoading.onNext(false)
                    self?.errorMessage.onNext("Error: \(error.localizedDescription)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func didSelectUser(_ user: User) {
        if coordinator == nil {
            print("ERROR: Coordinator is nil!")
            return
        }
        coordinator?.showUserDetail(user: user)
    }
}
