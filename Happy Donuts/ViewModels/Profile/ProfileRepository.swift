//
//  ProfileRepository.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 01-09-22.
//

import Foundation

final class ProfileRespository {
    private let profileDataSource: ProfileDataSource
    
    init(profileDataSource: ProfileDataSource = ProfileDataSource()) {
        self.profileDataSource = profileDataSource
    }
    
    func getCurrentUser() -> UserModel? {
        self.profileDataSource.getCurrentUser()
    }
    
    
    func logout() throws {
        try profileDataSource.logout()
    }
    
    
    func getUserExtraData() async -> [UserExtraDataModel] {
        await profileDataSource.getUserExtraData()
    }
}
