//
//  SignupPresenter.swift
//  MVP Demo
//
//  Created by mac on 17/03/23.
//

import Foundation

protocol SignupPresenterView: AnyObject {
    func loading(isLoading: Bool)
    func showAlert(errorMsg: String)
    func userCreatedSuccess()
}

@MainActor class SignupPresenter {
    //MARK: - Properties
    weak var view: SignupPresenterView?
    let fireBaseServices: FirebaseServices
    
    //MARK: - LifeCycle
    init(view: SignupPresenterView, fireBaseServices: FirebaseServices = FireBaseManger()) {
        self.view = view
        self.fireBaseServices = fireBaseServices
    }
    
    //MARK: - Functions
    
    /* MARK: - WHTHOUT ASYNC/AWIAT
    func createUser(name: String, email: String, password: String) {
        view?.loading(isLoading: true)
        FirebaseManager.shared.createUser(email: email, password: password) { [weak self] result in
            self?.view?.loading(isLoading: false)
            switch result {
            case .success(let userModel):
                let model = UserProfileModel(name: name, email: userModel.email, id: userModel.id)
                self?.addUser(model: model, userId: userModel.id ?? "")
            case .failure(let error):
                self?.view?.showAlert(errorMsg: error.localizedDescription)
            }
        }
    }
    
    private func addUser(model: UserProfileModel, userId: String) {
        view?.loading(isLoading: true)
        FirebaseManager.shared.addUser(model: model, userId: userId) { [weak self] result in
            self?.view?.loading(isLoading: false)
            switch result {
            case .success():
                self?.view?.userCreatedSuccess()
            case .failure(let error):
                self?.view?.showAlert(errorMsg: error.localizedDescription)
            }
        }
    }
     */
    
    //MARK: - WHTH ASYNC/AWIAT
    func createUser(name: String, email: String, password: String) {
        view?.loading(isLoading: true)
        Task {
            do {
                let user = try await fireBaseServices.createUser(email: email, password: password)
                try await fireBaseServices.addUser(model: UserProfileModel(name: name, email: user.email, id: user.id), userId: user.id ?? "")
                self.view?.loading(isLoading: false)
                self.view?.userCreatedSuccess()
            } catch {
                self.view?.showAlert(errorMsg: error.localizedDescription)
            }
        }
    }
}
