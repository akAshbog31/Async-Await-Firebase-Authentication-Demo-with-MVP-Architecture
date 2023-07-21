//
//  FireBaseManager.swift
//  MvvmDemoFireBase
//
//  Created by mac on 03/11/22.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol FirebaseServices {
    var db: Firestore { get }
    
    func createUser(email: String, password: String) async throws -> UserProfileModel
    
    func addUser(model: UserProfileModel, userId: String) async throws -> Void
    
    func signIn(email: String, password: String) async throws -> Void
}

final class FireBaseManger: FirebaseServices {
    var db = Firestore.firestore()
    
    func createUser(email: String, password: String) async throws -> UserProfileModel {
        let authresult = try await Auth.auth().createUser(withEmail: email, password: password)
        UserDefaultType.userDefaultId = authresult.user.uid
        return UserProfileModel(name: authresult.user.displayName, email: authresult.user.email, id: authresult.user.uid)
    }
    
    func addUser(model: UserProfileModel, userId: String) async throws {
        try await db.collection("Users").document(userId).setData(model.dictionary)
    }
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
}
