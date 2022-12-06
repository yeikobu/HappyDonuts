//
//  ProfileDataSource.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 01-09-22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ProfileDataSource {
    private let database = Firestore.firestore()
    private let collection = "UserData"
    private let uid = String(describing: Auth.auth().currentUser?.uid)
    private let subColleciton = "userData"
    
    
    func getCurrentUser() -> UserModel? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        
        return .init(userEmail: email)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    @MainActor
    func getUserExtraData() async -> [UserExtraDataModel] {
        var userExtraDataModel = [UserExtraDataModel]()
        
        do {
            let query = try await database.collection(collection).document(uid).collection(subColleciton).getDocuments()
            let documents = query.documents.compactMap({$0})
            let userExtraData = documents.map { try? $0.data(as: UserExtraDataModel.self)}.compactMap{$0}
            userExtraDataModel = userExtraData
        } catch {
            print(error.localizedDescription)
        }
        
        return userExtraDataModel
    }
    
    
    @MainActor
    func setUserExtraData(userExtraData: UserExtraDataModel) {
        do {
            try database.collection(collection).document(uid).collection(subColleciton).document("deliveryData").setData(from: userExtraData)
        } catch {
            print(error.localizedDescription)
        }
    }

}
