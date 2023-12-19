//
//  LoginViewModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private var dataSource = ContentDataSource()
    
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    
}
