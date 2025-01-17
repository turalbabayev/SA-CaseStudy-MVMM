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
    private let userRepository = UserRepository()
    
    let users = PublishSubject<[User]>()
    let errorMessage = PublishSubject<String>()
    
    func loadUsers() {
        userRepository.fetchUsers()
            .subscribe(
                onNext: { [weak self] fetchedUsers in
                    self?.users.onNext(fetchedUsers)
                },
                onError: { [weak self] error in
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
