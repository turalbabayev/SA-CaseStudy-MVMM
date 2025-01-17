//
//  UserListViewController.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import UIKit
import RxSwift

class UserListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: UserListViewModel!
    private let disposeBag = DisposeBag()
    private var userList: [User] = [] // TableView için veri kaynağı
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil {
            print("ERROR: ViewModel is nil in viewDidLoad!") // Debug için
            return
        }
        
        setupTableView()
        setupBindings()
        viewModel.loadUsers()
    }
    
    private func setupTableView(){
        // TableView'in delegate ve data source'ünü ayarliyoruz.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupBindings(){
        viewModel.users
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] users in
                self?.userList = users
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                ErrorHandler.showAlert(on: self!, message: message)
            })
            .disposed(by: disposeBag)
    }
}

extension UserListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Hücreyi storyboard'daki identifier ile oluştur
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        // Kullanıcı bilgilerini hücreye aktar
        let user = userList[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = userList[indexPath.row]
        viewModel.didSelectUser(user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
