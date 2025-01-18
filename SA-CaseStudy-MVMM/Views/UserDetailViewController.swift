//
//  UserDetailViewController.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 18.01.2025.
//

import UIKit
import RxSwift

class UserDetailViewController: UIViewController {
    // MARK: - UI Components
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: UserDetailViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard viewModel != nil else {
            fatalError("ViewModel not initialized")
        }
        setupView()
    }
}

// MARK: - View Setup
private extension UserDetailViewController {
    func setupView() {
        setupNavigationBar()
        setupBindings()
    }
    
    func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
    }
}

// MARK: - Bindings
private extension UserDetailViewController {
    func setupBindings() {
        viewModel.userDetails
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] viewData in
                self?.updateUI(with: viewData)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UI Updates
private extension UserDetailViewController {
    func updateUI(with viewData: UserDetailViewModel.UserDetailViewData) {
        nameLabel.text = viewData.name
        emailLabel.text = viewData.email
        phoneLabel.text = viewData.phone
        websiteLabel.text = viewData.website
    }
}
