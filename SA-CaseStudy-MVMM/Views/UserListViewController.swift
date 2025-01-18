//
//  UserListViewController.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import UIKit
import RxSwift

class UserListViewController: UIViewController {
    // MARK: - UI Components
    @IBOutlet weak var tableView: UITableView!
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Properties
    var viewModel: UserListViewModel!
    private let disposeBag = DisposeBag()
    private var userList: [User] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard viewModel != nil else {
            fatalError("ViewModel not initialized")
        }
        setupView()
        viewModel.loadUsers()
    }
}

// MARK: - View Setup
private extension UserListViewController {
    func setupView() {
        setupActivityIndicator()
        setupTableView()
        setupBindings()
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Bindings
private extension UserListViewController {
    func setupBindings() {
        bindUsers()
        bindLoading()
        bindError()
    }
    
    func bindUsers() {
        viewModel.users
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] users in
                self?.userList = users
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func bindLoading() {
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.updateLoadingState($0)
            })
            .disposed(by: disposeBag)
    }
    
    func bindError() {
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                self?.showError(message)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UI Updates
private extension UserListViewController {
    func updateLoadingState(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            tableView.alpha = 0.5
        } else {
            activityIndicator.stopAnimating()
            tableView.alpha = 1.0
        }
    }
    
    func showError(_ message: String) {
        ErrorHandler.showAlert(on: self, message: message)
    }
}

// MARK: - UITableView DataSource & Delegate
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: userList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectUser(userList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
