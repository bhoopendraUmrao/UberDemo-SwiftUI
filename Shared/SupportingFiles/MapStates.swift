//
//  MapStates.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import Foundation

enum MapState {
    case noInput
    case locationSelected
    case locationSearch
}

enum VeichelType: Int, CaseIterable, Identifiable {
    case uberX
    case uberBlack
    case uberXL
    
    var id: Int {
        return rawValue
    }
    
    var title: String {
        switch self {
        case .uberX:
            return "Uber X"
        case .uberBlack:
            return "Uber Black"
        case .uberXL:
            return "Uber XL"
        }
    }
    
    var image: String {
        switch self {
        case .uberX:
            return "uber-x"
        case .uberBlack:
            return "uber-black"
        case .uberXL:
            return "uber-x"
        }
    }
}

