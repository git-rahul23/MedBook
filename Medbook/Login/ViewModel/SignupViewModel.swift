//
//  SignupViewModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    private var dataSource = ContentDataSource()
    
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    
    @Published var userPassword: String = ""
    
    var hasMinimumCharacters: Bool {
        guard userPassword.count >= 8 else {
            return true
        }
        return true
    }
    
    var hasNumber: Bool {
        guard userPassword.count >= 8 else {
            return true
        }
        return userPassword.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    var hasUppercaseLetter: Bool {
        guard userPassword.count >= 8 else {
            return true
        }
        return userPassword.rangeOfCharacter(from: .uppercaseLetters) != nil
    }
    
    var hasSpecialCharacter: Bool {
        guard userPassword.count >= 8 else {
            return true
        }
        return userPassword.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{}|;:'\",.<>/?")) != nil
    }
    
    var isValidPassword: Bool {
        guard userPassword.count >= 8 else {
            return true
        }
        return hasMinimumCharacters && hasNumber && hasUppercaseLetter && hasSpecialCharacter
    }
    
    @Published var countries: [Country] = []
    @Published var country: String = ""
    
    init() {
        setupData()
    }
    
    private func setupData() {
        Task {
            let country = await self.dataSource.fetchCountry()
            switch country {
            case .success(let response):
                await fetchcountries(country: response?.country ?? "")
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    private func fetchcountries(country: String) async {
        
        let countries = await self.dataSource.fetchCountries()
        switch countries {
        case .success(let response):
            DispatchQueue.main.async {
                self.country = country
                if let data = response?.data {
                    self.countries = Array(data.values).sorted(by: { con1, con2 in
                        con1.country ?? "" < con2.country ?? ""
                    })
                }
            }
        case .failure(let err):
            print(err)
        }
    }
}
