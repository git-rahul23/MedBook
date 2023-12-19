//
//  SignUpView.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var isSkipped: Bool = false
    
    @ObservedObject var viewModel = SignupViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                NavigationLink("", destination: BookListingView(), isActive: $isSkipped)
                
                mainView
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle(Text(""), displayMode: .inline)
                    .navigationBarItems(trailing:
                                            Button(action: {
                        self.isSkipped = true
                    }, label: {
                        Text("SKIP")
                    })
                    )
            }
        }
        .navigationBarHidden(true)
    }
    
    var mainView: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(alignment: .leading) {
                Text("CREATE")
                    .font(.appFont(.medium, size: 24))
                
                Text("NEW")
                    .font(.appFont(.bold, size: 24))
                    .foregroundColor(Color.brown)
                +
                Text(" ACCOUNT")
                    .font(.appFont(.medium, size: 24))
            }
            .padding(.bottom, 24)
            
            
            VStack {
                TextField("Name", text: $viewModel.userName)
                
                Divider()
                    .background(Color.black)
            }
            
            VStack {
                TextField("Email", text: $viewModel.userEmail)
                Divider()
                    .background(Color.black)
            }
            
            VStack(alignment: .leading) {
                
                TextField("Password", text: $viewModel.userPassword)
                
                Divider()
                    .background(Color.black)
                
                Text("Password must have:")
                    .font(.appFont(.regular, size: 12))
                    .foregroundColor(.black)
                    .padding(.top, 5)
                
                Text("• At least 8 characters")
                    .font(.appFont(.medium, size: 12))
                    .foregroundColor(viewModel.hasMinimumCharacters ? .green : .red)
                
                Text("• At least one number")
                    .font(.appFont(.medium, size: 12))
                    .foregroundColor(viewModel.hasNumber ? .green : .red)
                
                Text("• At least one uppercase letter")
                    .font(.appFont(.medium, size: 12))
                    .foregroundColor(viewModel.hasUppercaseLetter ? .green : .red)
                
                Text("• At least one special character")
                    .font(.appFont(.medium, size: 12))
                    .foregroundColor(viewModel.hasSpecialCharacter ? .green : .red)
            }
            
            if viewModel.countries.count > 0 {
                Picker("", selection: $viewModel.country) {
                    ForEach(0..<viewModel.countries.count, id: \.self) { index in
                        Text(viewModel.countries[index].country ?? "")
                            .tag(viewModel.countries[index].country ?? "")
                    }
                }
                .pickerStyle(.wheel)
            }
            
            Spacer()
            
            
            Button {
                //
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
