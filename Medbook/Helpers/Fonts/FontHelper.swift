//
//  FontHelper.swift
//  Medbook
//
//  Created by RAHUL RANA on 19/12/23.
//

import SwiftUI

enum AppFontType {
    case bold
    case semiBold
    case medium
    case regular
    
    var custom: String {
        switch self {
        case .bold:
            return "Montserrat-Bold"
        case .semiBold:
            return "Montserrat-SemiBold"
        case .medium:
            return "Montserrat-Medium"
        case .regular:
            return "Montserrat-Regular"
        }
    }
}

extension Font {
    static func appFont(_ type: AppFontType, size: CGFloat) -> Self {
        return Self.custom(type.custom, size: size)
    }
}
