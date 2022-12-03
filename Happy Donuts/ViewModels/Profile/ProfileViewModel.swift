//
//  ProfileViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 01-09-22.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var userModel: UserModel?
    @Published var userExtraDataModel: UserExtraDataModel = UserExtraDataModel()
    @Published var isLogoutPressed: Bool = false
    @Published var isEditPressed: Bool = false
    @Published var isLocationTapped: Bool = false
    var errorMessage: String = ""
    private let profileRepository: ProfileRespository

    
    init(profileRepository: ProfileRespository = ProfileRespository()) {
        self.profileRepository = profileRepository
        
        getCurrentUser()
    }
    
    
    func getCurrentUser() {
        self.userModel = profileRepository.getCurrentUser()
    }
    
    
    func logout() {
        do {
            try profileRepository.logout()
            self.userModel = nil
        } catch {
            print(error)
        }
    }
    
    
    @MainActor
    func getUserExtraData() async {
        let userData = await self.profileRepository.getUserExtraData()
        userData.forEach { data in
            self.userExtraDataModel = data
        }
    }
    
    @MainActor
    func setUserExtraData(userExtraData: UserExtraDataModel) {
        if userExtraData.name != "" || userExtraData.phone != "" || userExtraData.location != ""  {
            profileRepository.setUserExtraData(userExtraData: userExtraData)
        } else {
            self.errorMessage = "Los campos no deben estar vacíos"
            print(self.errorMessage)
        }
    }
    
}
