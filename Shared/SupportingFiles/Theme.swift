//
//  Theme.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import Foundation
import SwiftUI


extension Color {
    static var theme: ColorTheme = ColorTheme()
}


struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}
