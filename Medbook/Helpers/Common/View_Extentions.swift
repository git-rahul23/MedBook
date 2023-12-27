//
//  View_Extentions.swift
//  Medbook
//
//  Created by RAHUL RANA on 27/12/23.
//

import SwiftUI

extension View {
    func toast(isPresented: Binding<Bool>, message: String, type: ToastType) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, type: type))
    }
    
    
    func textValidation(isValid: Bool?) -> some View {
        self.modifier(ValidationTextModifier(isValid: isValid))
    }
}
