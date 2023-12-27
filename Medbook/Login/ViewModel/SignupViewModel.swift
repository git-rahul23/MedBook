//
//  SignupViewModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import Foundation
import CoreData

class SignupViewModel: ObservableObject {
    
    private var dataSource = ContentDataSource()
    
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    
    
    @Published var isSkipped: Bool = false
    
    @Published var showToast: Bool = false
    var toastMessage: String = ""
    var toastType: ToastType = .error
    
    var hasMinimumCharacters: Bool? {
        
        guard userPassword.count >= 8 else {
            return nil
        }
        return true
    }
    
    var hasNumber: Bool? {
        guard hasMinimumCharacters != nil else {
            return nil
        }
        guard userPassword.count >= 8 else {
            return true
        }
        return userPassword.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    var hasUppercaseLetter: Bool? {
        
        guard hasMinimumCharacters != nil else {
            return nil
        }
        
        guard userPassword.count >= 8 else {
            return true
        }
        return userPassword.rangeOfCharacter(from: .uppercaseLetters) != nil
    }
    
    var hasSpecialCharacter: Bool? {
        
        guard hasMinimumCharacters != nil else {
            return nil
        }
        
        guard userPassword.count >= 8 else {
            return true
        }
        return userPassword.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{}|;:'\",.<>/?")) != nil
    }
    
    private var isValidPassword: Bool {
        guard userPassword.count >= 8 else {
            return true
        }
        return (hasMinimumCharacters ?? false) && (hasNumber ?? false) && (hasUppercaseLetter ?? false) && (hasSpecialCharacter ?? false)
    }
    
    
    private var isValidName: Bool {
        guard !userName.isEmpty else {
            return false
        }
        
        return true
    }
    
    private var isValidEmail: Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self.userEmail)
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
    
    func signupTapped() {
        
        if !isValidName {
            self.toastMessage = "Enter a valid name"
            self.showToast = true
            return
        }
        
        
        if !isValidEmail {
            self.toastMessage = "Enter a valid email"
            self.showToast = true
            return
        }
        
        if !isValidPassword {
            self.toastMessage = "Enter a valid password"
            self.showToast = true
            return
        }
        
        if checkIfEmailExists() {
            self.toastMessage = "Email Already Exists"
            self.showToast = true
            return
        }
        saveUser()
    }
    
    
    private func checkIfEmailExists() -> Bool {
        
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", userEmail)

        do {
            let users = try context.fetch(fetchRequest)
            return !users.isEmpty
        } catch {
            print("Error checking for existing user: \(error.localizedDescription)")
            return false
        }
    }
    
    private func saveUser() {
        let context = PersistenceController.shared.container.viewContext
        let appUser = AppUser(context: context)
        appUser.name = self.userName
        appUser.email = self.userEmail
        appUser.password = self.userPassword
        
        do {
            try context.save()
            isSkipped = true
            UserDefaultHelper.setLoggedIn(true)
        } catch {
            self.toastMessage = "Unable to signup at this moment"
            self.showToast = true
            print("Error saving user: \(error.localizedDescription)")
        }
    }
}
