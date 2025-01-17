//
//  UserDetailViewController.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 18.01.2025.
//

import UIKit
import RxSwift

class UserDetailViewController: UIViewController {
    var viewModel: UserDetailViewModel!
    private let disposeBag = DisposeBag()

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.userDetails
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] viewData in
                self?.updateUI(with: viewData)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUI(with viewData: UserDetailViewModel.UserDetailViewData) {
        nameLabel.text = viewData.name
        emailLabel.text = viewData.email
        phoneLabel.text = viewData.phone
        websiteLabel.text = viewData.website
    }
    


}
