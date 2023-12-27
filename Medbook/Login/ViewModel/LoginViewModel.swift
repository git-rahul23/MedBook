//
//  LoginViewModel.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import Foundation
import CoreData

class LoginViewModel: ObservableObject {
    
    private var dataSource = ContentDataSource()
    
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    
    @Published var isSkipped: Bool = false
    
    @Published var showToast: Bool = false
    var toastMessage: String = ""
    var toastType: ToastType = .error
    
    func loginTapped() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", userEmail, userPassword)
        
        do {
            let users = try context.fetch(fetchRequest)
            if users.isEmpty {
                self.toastMessage = "Incorrect credentials entered"
                self.toastType = .error
                self.showToast = true
                
            } else {
                self.toastMessage = "Logged In Successfully"
                self.toastType = .success
                self.showToast = true
                self.isSkipped = true
                UserDefaultHelper.setLoggedIn(true)
            }
        } catch {
            self.toastMessage = "Unable to login at this moment"
            self.toastType = .error
            self.showToast = true
        }
    }
    
}
