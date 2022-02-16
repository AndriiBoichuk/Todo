//
//  FontExtention.swift
//  ToDoList
//
//  Created by user on 16.02.2022.
//

import Foundation
import SwiftUI

enum Poppins: String {
    case semiBold = "Poppins-SemiBold"
    case regular = "Poppins-Regular"
    case light = "Poppins-Light"
}

extension Font {
    static func custom(_ font: Poppins, size: CGFloat) -> Font {
        custom(font.rawValue, fixedSize: size)
    }
}
