//
//  AppLandingView.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import SwiftUI

struct AppLandingView: View {
    
    private let width = UIScreen.main.bounds.width - 60
    
    @State var isMoveToSignup: Bool = false
    @State var isMoveToLogin: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                NavigationLink("", destination: SignUpView(), isActive: $isMoveToSignup)
                NavigationLink("", destination: LoginView(), isActive: $isMoveToLogin)

                mainView
            }
        }
       
        
    }
    
    var mainView: some View {
        VStack(alignment: .center) {
            
            Text("MEDBOOK")
                .font(.appFont(.bold, size: 54))
                .foregroundColor(.white)
                .shadow(color: Color.black, radius: 2, x: 0, y: 1)
            
            Spacer()
            
            HStack {

                Button {
                    isMoveToSignup = true
                } label: {
                    Text("SIGNUP")
                        .font(.appFont(.semiBold, size: 16))
                        .foregroundColor(.black)
                }
                .frame(width: width/2, height: 42)
                .overlay {
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(.gray, lineWidth: 1)

                }
                
                Button {
                    isMoveToLogin = true
                } label: {
                    Text("LOGIN")
                        .font(.appFont(.semiBold, size: 16))
                        .foregroundColor(.white)
                }
                .frame(width: width/2, height: 42)
                .background(Color.black)
                .cornerRadius(7)

            }
            .padding(.horizontal, 24)
        }
        .padding(.vertical, 48)
        .background(
            Image("landingBG").opacity(0.8)
        )
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct AppLandingView_Previews: PreviewProvider {
    static var previews: some View {
        AppLandingView()
    }
}

