//
//  LoginView.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                NavigationLink("", destination: BookListingView(isOpen: $viewModel.isSkipped), isActive: $viewModel.isSkipped)
                
                mainView
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle(Text(""), displayMode: .inline)
                    .navigationBarItems(trailing:
                                            Button(action: {
                        viewModel.isSkipped = true
                    }, label: {
                        Text("SKIP")
                    })
                    )
                    .toast(isPresented: $viewModel.showToast, message: viewModel.toastMessage, type: viewModel.toastType)
            }
        }
        .navigationBarHidden(true)
    }
    
    var mainView: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(alignment: .leading) {
                Text("LOGIN")
                    .font(.appFont(.medium, size: 24))
                
                Text("TO")
                    .font(.appFont(.bold, size: 24))
                    .foregroundColor(Color.brown)
                +
                Text(" CONTINUE")
                    .font(.appFont(.medium, size: 24))
            }
            .padding(.bottom, 24)
            
            VStack {
                TextField("Email", text: $viewModel.userEmail)
                Divider()
                    .background(Color.black)
            }
            
            VStack(alignment: .leading) {
                
                SecureField("Password", text: $viewModel.userPassword)
                
                Divider()
                    .background(Color.black)
            }
            
            Spacer()
            
            
            Button {
                viewModel.loginTapped()
            } label: {
                Text("PROCEED")
                    .font(.appFont(.semiBold, size: 14))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 42)
            .background(Color.black)
            .cornerRadius(7)

        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
