//
//  AppToast.swift
//  Medbook
//
//  Created by RAHUL RANA on 27/12/23.
//

import SwiftUI

enum ToastType {
    case success
    case error
    
    var color: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        }
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    var message: String
    var type: ToastType
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                ToastView(message: message, type: type)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
            }
        }
    }
}

struct ToastView: View {
    var message: String
    var type: ToastType
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .foregroundColor(.white)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 48)
                .background(type.color)
                .cornerRadius(10)
                .padding(.bottom, 50)
        }
    }
}

struct ValidationTextModifier: ViewModifier {
    var isValid: Bool?
    
    func body(content: Content) -> some View {
        if let isValid = isValid {
            content
                .foregroundColor(isValid ? .green : .red)
        } else {
            content
                .foregroundColor(.gray)
        }
    }
}
