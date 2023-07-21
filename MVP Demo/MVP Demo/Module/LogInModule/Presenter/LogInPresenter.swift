//
//  LogInPresenter.swift
//  MVP Demo
//
//  Created by mac on 17/03/23.
//

import Foundation

protocol LogInPresenterView: AnyObject {
    func loading(isLoading: Bool)
    func showAlert(errorMsg: String)
    func logInSuccess()
}

@MainActor final class LogInPresenter {
    //MARK: - Properties
    weak var view: LogInPresenterView?
    let firebaseServices: FirebaseServices
    
    //MARK: - LifeCycle
    init(view: LogInPresenterView, firebaseServices: FirebaseServices = FireBaseManger()) {
        self.view = view
        self.firebaseServices = firebaseServices
    }
    
    //MARK: - Functions
    
    /* MARK: - WHTHOUT ASYNC/AWIAT
    func logIn(email: String, password: String) {
        view?.loading(isLoading: true)
        FirebaseManager.shared.signIn(email: email, password: password) { [weak self] result in
            self?.view?.loading(isLoading: false)
            switch result {
            case .success():
                self?.view?.logInSuccess()
            case .failure(let error):
                self?.view?.showAlert(errorMsg: error.localizedDescription)
            }
        }
    }
     */
    
    //MARK: - WHTH ASYNC/AWIAT
    func logIn(email: String, password: String) {
        view?.loading(isLoading: true)
        Task {
            do {
                try await firebaseServices.signIn(email: email, password: password)
                self.view?.loading(isLoading: false)
                self.view?.logInSuccess()
            } catch {
                self.view?.showAlert(errorMsg: error.localizedDescription)
            }
        }
    }
}
