//
//  UberHomeView.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import SwiftUI

struct UberHomeView: View {
    @State private var mapState: MapState = .noInput
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                switch mapState {
                case .noInput:
                    UberMapRepresentable(mapState: $mapState)
                    LocationSearchActivationView(mapState: $mapState)
                        .padding(.top, 115)
                case .locationSelected:
                    UberMapRepresentable(mapState: $mapState)
                case .locationSearch:
                    LocationSearchView(mapState: $mapState)
                        .padding(.top, 100)
                }
                UserHomeActionView(mapState: $mapState)
                    .padding(.leading, 20)
                    .padding(.top, 50)
            }
            .ignoresSafeArea()
            if mapState == .locationSelected {
                TripView()
                    .transition(.move(edge: .bottom))
            }
        }
        .background(Color.theme.backgroundColor)
        .ignoresSafeArea()
        
    }
}

struct UberHomeView_Previews: PreviewProvider {
    static var previews: some View {
        UberHomeView()
    }
}
