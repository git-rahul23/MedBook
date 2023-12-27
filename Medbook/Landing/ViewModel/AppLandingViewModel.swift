//
//  AppLandingViewModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 27/12/23.
//

import SwiftUI

class AppLandingViewModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    @Published var isChecking: Bool = false
    
    func checkIfLoggedIn() {
        self.isChecking = true
        
        if UserDefaultHelper.isLoggedIn() {
            self.isChecking = false
            self.isLoggedIn = true
        } else {
            self.isChecking = false
            self.isLoggedIn = false
        }
        
    }
}
