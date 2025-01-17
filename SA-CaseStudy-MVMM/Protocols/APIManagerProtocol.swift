


import RxSwift

protocol APIManagerProtocol {
    func fetchUsers() -> Observable<[User]>
}

extension APIManager: APIManagerProtocol { } 
